settings = require('./settings')
mongodb = require('mongodb')

class LocationService
    constructor: ->
        server = new mongodb.Server settings.get('MONGO_NODE_DRIVER_HOST'), settings.get('MONGO_NODE_DRIVER_PORT'), {}
        @db = new mongodb.Db settings.get('MONGO_NODE_DATABASE'), server, {}
        console.log "Authenticating to server #{settings.get('MONGO_NODE_DRIVER_HOST')}:#{settings.get('MONGO_NODE_DRIVER_PORT')}"
        @db.open (err, db2) =>
            console.log err if err?
            @db.authenticate settings.get('MONGO_NODE_USERNAME'), settings.get('MONGO_NODE_PASSWORD'), (err, replies) ->
                console.log err if err?

    search: (latitude, longitude, callback) ->
        @db.collection 'locations', (err, collection) ->
            collection.find {geometry: {$near: [parseFloat(longitude), parseFloat(latitude)]}}, {}, (err, cursor) ->
                cursor.toArray (err, items) ->
                    callback items

    location: (locId, callback) ->
        @db.collection 'locations', (err, collection) ->
            collection.find {'OBJECTID': parseInt(locId)}, (err, cursor) ->
                cursor.toArray (err, items) ->
                    callback items[0]

exports.LocationService = LocationService
