should = require('chai').should()
fixtures = require './fixtures/locations.json'
HoursProcessor = require('../hours-parser').HoursProcessor

describe "hours-parser", ->
    before ->
        @processor = new HoursProcessor()

    describe "days", ->
        it "should be able to handle Mon - Sun", ->
            days = @processor.processHours "Mon - Sun", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [0..6]

        it "should be able to handle Sat - Sun", ->
            days = @processor.processHours "Sat - Sun", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [0, 6]
            days.should.not.have.property(i) for i in [1..5]

        it "should be able to handle Tue - Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Tue - Sat", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [2..6]
            days.should.not.have.property(i) for i in [0, 1]

        it "should be able to handle Mon - Wed & Fri", ->
            location = fixtures[0]
            days = @processor.processHours "Mon - Wed & Fri", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [1..3]
            days.should.not.have.property(i) for i in [0, 4, 6]

        it "should be able to handle Tue, Thur & Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Tue, Thur & Sat", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [2, 4, 6]
            days.should.not.have.property(i) for i in [0, 1, 3, 5]

        it "should be able to handle Mon, Tue, Wed, & Fri", ->
            location = fixtures[0]
            days = @processor.processHours "Mon, Tue, Wed, & Fri", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [1, 2, 3, 5]
            days.should.not.have.property(i) for i in [-1, 0, 4, 6]

        it "should be able to handle Mon & Sat", ->
            location = fixtures[0]
            days = @processor.processHours "Mon & Sat", "7:30 am - 5 pm"
            days.should.have.property(i) for i in [1, 6]
            days.should.not.have.property(i) for i in [2..5].unshift(0)

    describe "times", ->
        it "should have an open time", ->
            days = @processor.processHours "Mon - Sun", "7:30 am - 5 pm"
            days[i].open.should.equal(730) for i in [0..6]

        it "should be able to handle an open time of 12:00 pm", ->
            days = @processor.processHours "Mon - Sun", "12:00 pm - 5 pm"
            days[i].open.should.equal(1200) for i in [0..6]

        it "should have a close time", ->
            days = @processor.processHours "Mon - Sun", "7:30 am - 5 pm"
            days[i].close.should.equal(1700) for i in [0..6]

        it "should be able to handle a close time of 12:00 noon", ->
            days = @processor.processHours "Sat", "8 am - 12 noon"
            days[6].close.should.equal(1200)
