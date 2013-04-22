Client = require('mongodb').MongoClient

class MongoConnection
    constructor: (@mongoUrl) ->
        @collections = {}

    connect: (callback) ->
        # console.log "Authenticating to server at #{@mongoUrl}."
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
                @getCollection collectionName, callback


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

    find: (collectionName, params, callback) ->
        @getCollection collectionName, (collection) ->
            collection.find params, (err, cursor) ->
                cursor.toArray (err, items) ->
                    callback items

    executeCommand: (params, callback) ->
        if @db?
            @db.executeDbCommand params, (err, response) ->
                callback response.documents[0].results
        else
            @connect (db) =>
                @executeCommand params, callback

    close: ->
        @db.close()
        @collections = {}

module.exports.Connection = MongoConnection
