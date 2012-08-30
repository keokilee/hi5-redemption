settings = require('./settings')
http = require('http')

mongodb = require('mongodb')
Db = mongodb.Db
Server = mongodb.Server

server = new Server settings.get('MONGO_NODE_DRIVER_HOST'), settings.get('MONGO_NODE_DRIVER_PORT'), {}
db = new Db('hi5-redemption', server, {})

_remoteCallback = (response) ->
    body = ''
    response.on 'data', (chunk) ->
        body += chunk

    response.on 'end', ->
        db.open (err, db) ->
            db.collection 'locations', (err, collection) ->
                # Erase all records from the collection, if any
                data = JSON.parse(body)
                _reloadLocations(data, collection, db)

_reloadLocations = (data, collection, db) ->
    console.log('Reloading locations')
    collection.remove {}, (err, result) ->
        _processAttributes(collection, location.attributes, location.geometry) for location in data.features
        collection.count (err, count) ->
            console.log("Loaded " + count + " locations.");
            db.close()

_processAttributes = (mongo, attributes, geometry) ->
    attributes.geometry = geometry
    mongo.insert(attributes)

getLocations = (latitude, longitude, callback) ->
    db.open (err, db) ->
        db.collection 'locations', (err, collection) ->
            collection.find (err, cursor) ->
                cursor.toArray (err, items) ->
                    console.log items
                    callback items
                    db.close()

location = (locId, callback) ->
    db.open (err, db) ->
        db.collection 'locations', (err, collection) ->
            collection.find {'OBJECTID': locId}, (err, cursor) ->
                cursor.toArray (err, items) ->
                    callback items[0]
                    db.close()


exports.loadData = ->
    http.request(settings.get('QUERY_URL'), _remoteCallback).end()

exports.get = getLocations
exports.location = location
