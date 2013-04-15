require('source-map-support').install()
settings = require('../settings')
http = require('http')
Client = require('mongodb').MongoClient
HoursProcessor = require('../hours-parser').HoursProcessor
_ = require 'underscore'

class MongoConnection
    constructor: (@mongoUrl) ->
        @collections = {}

    connect: (callback) ->
        console.log "Authenticating to server at #{@mongoUrl}."
        Client.connect @mongoUrl, (err, db) =>
            @db = db
            callback db

    getCollection: (collectionName, callback) ->
        if @collections[collectionName]
            callback @collections[collectionName]
        else if @db?
            @db.collection collectionName, (err, collection) =>
                @collections[collectionName] = collection
                callback collection

        else
            @connect (db) =>
                db.collection collectionName, (err, collection) =>
                    @collections[collectionName] = collection
                    callback collection


    clear: (collectionName, callback) ->
        @getCollection collectionName, (collection) ->
            collection.remove {}, (err, result) ->
                callback result


    insert: (collectionName, doc, callback) ->
        @getCollection collectionName, (collection) ->
            collection.insert doc, (err, response) ->
                callback response

    rebuildIndex: (collectionName, indexParams, callback) ->
        @getCollection collectionName, (collection) ->
            collection.dropIndexes (err) ->
                collection.ensureIndex indexParams, (err) ->
                    callback()

    close: ->
        @db.close()
        @collections = {}

class ArcGisLoader
    constructor: (@mongo, @collectionName) ->
        @hoursProcessor = new HoursProcessor()

    fetch: (sourceUrl, completeCallback) ->
        console.log "Retrieving data from #{sourceUrl}"
        request = http.request sourceUrl, (response) ->
            body = ""
            response.on 'data', (chunk) ->
                body += chunk

            response.on 'end', ->
                completeCallback body

        request.end()

    reloadData: (contents) ->
        @clearLocations =>
            data = JSON.parse contents
            @processLocations data

    clearLocations: (callback) ->
        @mongo.clear @collectionName, ->
            callback()

    processLocations: (data, collection, db) ->
        locations = (@processLocation(l) for l in data.features)
        @mongo.insert @collectionName, locations, =>
            @mongo.rebuildIndex @collectionName, {geometry: "2d"}, =>
                console.log "Loaded #{locations.length} locations."
                @mongo.close()

    processLocation: (location) ->
        attributes = location.attributes
        console.log location
        attributes.geometry = [location.geometry.x, location.geometry.y]
        attributes.hours = @hoursProcessor.processHours attributes.DAYS, attributes.HOURS
        if attributes.WEEKEND != " "
            _.extend(attributes.hours, @hoursProcessor.processHours(attributes.WEEKEND, attributes.WEEKEND_HO))
        return attributes


# Main method for loading data.
main = ->
    mongo = new MongoConnection(settings.get 'MONGO_URL')
    loader = new ArcGisLoader(mongo, "locations")
    loader.fetch settings.get('QUERY_URL'), (body) ->
        loader.reloadData body

if require.main == module
    main()

else
    exports.ArcGisLoader = ArcGisLoader
    exports.MongoConnection = MongoConnection
