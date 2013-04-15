should = require('chai').should()
downloader = require '../locations/downloader'
fixtures = require './fixtures/locations.json'

describe "downloader", ->
    describe "locations", ->
        before ->
            @loader = new downloader.ArcGisLoader

        describe "hours", ->
            it "should have a hours field", ->
                attributes = @loader.processLocation fixtures[0]
                attributes.hours.should.be.ok

            it "should handle weekend hours", ->
                attributes = @loader.processLocation fixtures[1]
                attributes.hours.should.have.property(0)
                attributes.hours[0].should.not.equal attributes.hours[1]
