describe 'Location', ->
    beforeEach ->
        @location = new window.app.Location()

    it "should exist", ->
        @location.should.be.ok

    it "should be an instance of a Backbone model", ->
        @location.should.be.an.instanceof Backbone.Model

    it "should have the company in the full name", ->
        attrs =
            NAME: "test"
            COMPANY: "company"

        @location.attributes = attrs
        @location.fullName().should.equal "#{attrs.NAME} (#{attrs.COMPANY})"
