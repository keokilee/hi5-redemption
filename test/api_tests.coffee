should = require 'should'
request = require 'supertest'
express = require 'express'
api = require('../routes').api

describe "#locations", ->
    before ->
        @app = express()
        @app.get('/locations', api.locations)

    it "should return an error message if request has no latitude or longitude", (done) ->
        request(@app).get('/locations').expect(200).end (err, res) ->
            res.body.error.should.be.ok
            done()

    it "should return an error message if the latitude is incorrect", (done) ->
        request(@app).get('/locations?lat=1000000&long=0.0').expect(200).end (err, res) ->
            res.body.error.should.be.ok
            done()

    it "should return an error message if the longitude is incorrect", (done) ->
        request(@app).get('/locations?lat=0.0&long=100000').expect(200).end (err, res) ->
            res.body.error.should.be.ok
            done()

describe "#locations/:id", ->
    before ->
        @app = express()
        @app.get('/locations/:id', api.location)

    it "should return a 404 if the location is not found", (done) ->
        request(@app).get('/locations/1000000').expect(404, done)
