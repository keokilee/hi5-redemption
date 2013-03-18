require('source-map-support').install()
settings = require('../settings')
http = require('http')
Client = require('mongodb').MongoClient

remoteCallback = (response) ->
    body = ''
    response.on 'data', (chunk) ->
        body += chunk

    response.on 'end', ->
        console.log body
        console.log "Authenticating to server at #{settings.get('MONGO_URL')}."
        Client.connect settings.get('MONGO_URL'), (err, db) ->
            db.collection 'locations', (err, collection) ->
                data = JSON.parse(body)
                reloadLocations(data, collection, db)       

reloadLocations = (data, collection, db) ->
    console.log('Reloading locations')
    # Erase all records from the collection, if any
    collection.remove {}, (err, result) ->
        processAttributes(collection, location.attributes, location.geometry) for location in data.features
        # Create index.
        console.log "Establishing index."
        collection.dropIndexes (err) ->
            collection.ensureIndex {geometry: "2d"}, (err) ->
                console.log(err) if err?
                collection.count (err, count) ->
                    console.log("Loaded " + count + " locations.");
                    db.close()

processAttributes = (mongo, attributes, geometry) ->
    attributes.geometry = [geometry.x, geometry.y]
    mongo.insert attributes, (err, res) ->
        # Don't need to do anything here

# Main method for loading data.
main = ->
    http.request(settings.get('QUERY_URL'), remoteCallback).end()

if require.main == module
    main()
