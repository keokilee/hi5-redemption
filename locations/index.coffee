Client = require('mongodb').MongoClient

# Private functions
processResult = (result) ->
    item = result.obj
    # 69 miles per degree is an approximation.
    # Fortunately, since we're closer to the equator, it's relatively accurate.
    distance = (result.dis * 69.0).toFixed(1)
    item.DISTANCE = "#{distance} miles away"

    return item

authenticateDb = (connectionUrl, callback) ->
    Client.connect connectionUrl, (err, db) =>
        callback err, db

class LocationService
    # Constructor for the class.
    constructor: (connectionUrl) ->
        @connectionUrl = connectionUrl

    search: (latitude, longitude, callback) ->
        locationParams =
            geoNear: "locations"
            near: [parseFloat(longitude), parseFloat(latitude)]

        authenticateDb @connectionUrl, (err, db) ->
            db.executeDbCommand locationParams, (err, response) ->
                items = (processResult(result) for result in response.documents[0].results)
                callback items
                db.close()

    location: (locId, callback) ->
        authenticateDb @connectionUrl, (err, db) ->
            db.collection 'locations', (err, collection) ->
                collection.find {'OBJECTID': parseInt(locId)}, (err, cursor) ->
                    cursor.toArray (err, items) ->
                        callback items[0]
                        db.close()

exports.LocationService = LocationService
