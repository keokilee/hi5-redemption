api = require('../routes').api

describe 'routes', ->
    describe '#api.locations', ->
        it "should be a function", ->
            api.locations.should.be.a.function
