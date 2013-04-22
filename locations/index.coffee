Connection = require('./connection').Connection

# Private functions
processResult = (result) ->
    item = result.obj
    # 69 miles per degree is an approximation.
    # Fortunately, since we're closer to the equator, it's relatively accurate.
    distance = (result.dis * 69.0).toFixed(1)
    item.DISTANCE = "#{distance} miles away"

    return item

class LocationService
    # Constructor for the class.
    constructor: (connectionUrl) ->
        @connectionUrl = connectionUrl

    search: (latitude, longitude, callback) ->
        locationParams =
            geoNear: "locations"
            near: [parseFloat(longitude), parseFloat(latitude)]

        connection = new Connection @connectionUrl

        connection.executeCommand locationParams, (results) ->
            items = (processResult(result) for result in results)
            callback items
            connection.close()

    location: (locId, callback) ->
        connection = new Connection @connectionUrl

        connection.find 'locations', {'OBJECTID': parseInt(locId)}, (items) ->
            callback items[0]
            connection.close()

exports.LocationService = LocationService
