should = require('chai').should()
request = require 'supertest'
express = require 'express'
api = require('../routes').api

describe "locations", ->
    describe "processing", ->
