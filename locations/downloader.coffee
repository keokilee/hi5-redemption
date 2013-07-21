require('source-map-support').install()
settings = require('../settings')
Connection = require('./connection').Connection
http = require('http')
HoursProcessor = require('../hours-parser').HoursProcessor
_ = require 'underscore'

class Loader
    constructor: ->
        new Error("Abstract class")

    hoursProcessor: new HoursProcessor()

    loadData: (contents) ->
        data = @processData contents
        locations = @processLocations data
        @writeData locations

    clearLocations: (callback) ->
        new Error("Abstract method")

    writeData: (locations) ->
        new Error("Abstract method")

    fetch: (sourceUrl, completeCallback) ->
        request = http.request sourceUrl, (response) ->
            body = ""
            response.on 'data', (chunk) ->
                body += chunk

            response.on 'end', ->
                completeCallback body

        request.end()

    processData: (contents) ->
        JSON.parse contents

    processLocations: (data) ->
        locations = (@processLocation(l) for l in data.features)

    processLocation: (location) ->
        attributes = location.attributes
        attributes.geometry = [location.geometry.x, location.geometry.y]
        attributes.hours = @hoursProcessor.processHours attributes.DAYS, attributes.HOURS
        if attributes.WEEKEND != " "
            _.extend attributes.hours, @hoursProcessor.processHours(attributes.WEEKEND, attributes.WEEKEND_HO)
        return attributes

class JsonLoader extends Loader
    constructor: ->

    clearLocations: (callback) ->
        # this is a no-op for this loader, as it just outputs to console.
        callback()

    writeData: (locations) ->
        locations

class MongoLoader extends Loader
    constructor: (@mongo, @collectionName) ->

    clearLocations: (callback) ->
        @mongo.clear @collectionName, ->
            callback()

    writeData: (locations) ->
        @mongo.insert @collectionName, locations, =>
            @mongo.rebuildIndex @collectionName, {geometry: "2d"}, =>
                console.log "Loaded #{locations.length} locations."
                @mongo.close()

loadIntoMongo = (url, clear = true) ->
    mongo = new Connection(settings.get 'MONGO_URL')
    loader = new MongoLoader(mongo, "locations")
    loader.fetch url, (body) ->
        if clear
            loader.clearLocations ->
                loader.loadData body

        else
            loader.loadData body

loadIntoConsole = (url) ->
    loader = new JsonLoader()
    loader.fetch url, (body) ->
        locations = loader.loadData body
        console.log JSON.stringify(locations, null, 2)

# Main method for loading data.
main = ->
    loadIntoConsole settings.get('QUERY_URL')

if require.main == module
    main()

else
    exports.Loader = Loader
    exports.MongoLoader = MongoLoader
    exports.JsonLoader = JsonLoader
