settings = require('./settings')
http = require('http')
mongodb = require('mongodb')

server = new mongodb.Server settings.get('MONGO_NODE_DRIVER_HOST'), settings.get('MONGO_NODE_DRIVER_PORT'), {}
db = new mongodb.Db settings.get('MONGO_NODE_DATABASE'), server, {}

# Private methods for loading data.
_remoteCallback = (response) ->
    body = ''
    response.on 'data', (chunk) ->
        body += chunk

    response.on 'end', ->
        console.log "Authenticating to server at #{settings.get('MONGO_NODE_DRIVER_HOST')}:#{settings.get('MONGO_NODE_DRIVER_PORT')}"
        _authenticate (err, replies) ->
            db.collection 'locations', (err, collection) ->
                data = JSON.parse(body)
                _reloadLocations(data, collection, db)

_reloadLocations = (data, collection, db) ->
    console.log('Reloading locations')
    # Erase all records from the collection, if any
    collection.remove {}, (err, result) ->
        _processAttributes(collection, location.attributes, location.geometry) for location in data.features
        # Create index.
        console.log "Establishing index."
        collection.dropIndexes (err) ->
            collection.ensureIndex {geometry: "2d"}, (err) ->
                console.log(err) if err?
                collection.count (err, count) ->
                    console.log("Loaded " + count + " locations.");
                    db.close()

_processAttributes = (mongo, attributes, geometry) ->
    attributes.geometry = [geometry.x, geometry.y]
    console.log attributes
    mongo.insert(attributes)

_authenticate = (callback) ->
    db.open (err, db2) ->
        db.authenticate settings.get('MONGO_NODE_USERNAME'), settings.get('MONGO_NODE_PASSWORD'), (err, replies) ->
            callback(err, replies)

# Main method for loading data.
main = ->
    http.request(settings.get('QUERY_URL'), _remoteCallback).end()

if require.main == module
    main()
