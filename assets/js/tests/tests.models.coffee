describe "Models", ->
    describe 'Location', ->
        beforeEach ->
            @location = new window.app.Location()

        it "exists", ->
            @location.should.be.ok

        it "is an instance of a Backbone model", ->
            @location.should.be.an.instanceof Backbone.Model

        it "has the company in the full name", ->
            attrs =
                NAME: "test"
                COMPANY: "company"

            @location.attributes = attrs
            @location.fullName().should.equal "#{attrs.NAME} (#{attrs.COMPANY})"

        describe 'Hours', ->
            beforeEach ->
                @date = new Date()
                @today = @date.getDay()
                attrs = {hours:{}}
                @location.attributes = attrs

            it "displays a closed string if the location is closed today", ->
                @location.todaysHours().should.equal "Closed today"

            it "handles noon open time properly", ->
                @location.attributes.hours[@today] = {"open": 1200}
                @location.openTime(@date).should.equal "12:00 PM"

            it "handles 1630 close time properly", ->
                @location.attributes.hours[@today] = {"close": 1630}
                @location.closeTime(@date).should.equal "4:30 PM"

            it "displays hours for a given day", ->
                @location.attributes.hours[@today] = {"open": 900, "close": 1400}
                @location.todaysHours().should.have.string "9:00 AM"
                @location.todaysHours().should.have.string "2:00 PM"
