require('source-map-support').install()
settings = require('../settings')
Connection = require('./connection').Connection
http = require('http')
HoursProcessor = require('../hours-parser').HoursProcessor
_ = require 'underscore'

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
        attributes.geometry = [location.geometry.x, location.geometry.y]
        attributes.hours = @hoursProcessor.processHours attributes.DAYS, attributes.HOURS
        if attributes.WEEKEND != " "
            _.extend(attributes.hours, @hoursProcessor.processHours(attributes.WEEKEND, attributes.WEEKEND_HO))
        return attributes


# Main method for loading data.
main = ->
    mongo = new Connection(settings.get 'MONGO_URL')
    loader = new ArcGisLoader(mongo, "locations")
    loader.fetch settings.get('QUERY_URL'), (body) ->
        loader.reloadData body

if require.main == module
    main()

else
    exports.ArcGisLoader = ArcGisLoader
