settings = require('./settings')
mongodb = require('mongodb')

class LocationService
    constructor: ->
        console.log "Accessing MongoDB at #{settings.get('MONGO_NODE_DRIVER_HOST')}:#{settings.get('MONGO_NODE_DRIVER_PORT')}"
        server = new mongodb.Server settings.get('MONGO_NODE_DRIVER_HOST'), parseInt(settings.get('MONGO_NODE_DRIVER_PORT')), {}
        @db = new mongodb.Db settings.get('MONGO_NODE_DATABASE'), server, {}
        @db.open (err, db2) =>
            console.log err if err?
            if settings.get('MONGO_NODE_USERNAME')? and settings.get('MONGO_NODE_PASSWORD')?
                console.log "Authenticating to server"
                @db.authenticate settings.get('MONGO_NODE_USERNAME'), settings.get('MONGO_NODE_PASSWORD'), (err, replies) ->
                    console.log err if err?

    search: (latitude, longitude, callback) ->
        # Execute custom command to get distance in degrees.
        @db.executeDbCommand {geoNear: "locations", near: [parseFloat(longitude), parseFloat(latitude)]}, (err, response) =>
            items = (@_processResult(result) for result in response.documents[0].results)
            callback items

    _processResult: (result) ->
        item = result.obj
        # 69 miles per degree is an approximation.
        # Fortunately, since we're closer to the equator, it's relatively accurate.
        distance = (result.dis * 69.0).toFixed(1)
        item.DISTANCE = "#{distance} miles away"

        return item

    location: (locId, callback) ->
        @db.collection 'locations', (err, collection) ->
            collection.find {'OBJECTID': parseInt(locId)}, (err, cursor) ->
                cursor.toArray (err, items) ->
                    callback items[0]

exports.LocationService = LocationService
