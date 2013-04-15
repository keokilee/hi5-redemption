should = require('chai').should()
fixtures = require './fixtures/locations.json'
HoursProcessor = require('../hours-parser').HoursProcessor

describe "hours-parser", ->
    describe "days", ->
        before ->
            @processor = new HoursProcessor()
        it "should be able to handle Mon - Sun", ->
            days = @processor.processHours "Mon - Sun"
            days.should.have.property(i) for i in [0..6]

        it "should be able to handle Tue - Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Tue - Sat"
            days.should.have.property(i) for i in [2..6]
            days.should.not.have.property(i) for i in [0, 1]

        it "should be able to handle Mon - Wed & Fri", ->
            location = fixtures[0]
            days = @processor.processHours "Mon - Wed & Fri"
            days.should.have.property(i) for i in [1..3]
            days.should.not.have.property(i) for i in [0, 4, 6]

        it "should be able to handle Tue, Thur & Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Tue, Thur & Sat"
            days.should.have.property(i) for i in [2, 4, 6]
            days.should.not.have.property(i) for i in [0, 1, 3, 5]

        it "should be able to handle Mon, Tue, Wed, & Fri", ->
            location = fixtures[0]
            days = @processor.processHours "Mon, Tue, Wed, & Fri"
            days.should.have.property(i) for i in [1, 2, 3, 5]
            days.should.not.have.property(i) for i in [0, 4, 6]

        it "should be able to handle Mon & Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Mon & Sat"
            days.should.have.property(i) for i in [1, 6]
            days.should.not.have.property(i) for i in [2..5].unshift(0)