request = require 'supertest'
express = require 'express'
api = require('../routes').api

describe "#locations", ->
    before ->
        @app = express()
        @app.get('/locations', api.locations)

    it "should return a 404 if request has no latitude or longitude", (done) ->
        request(@app).get('/locations').expect(404, done)
