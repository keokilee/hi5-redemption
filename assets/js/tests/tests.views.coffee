describe "Views", ->
    describe 'LocationItemView', ->
        beforeEach ->
            @view = new window.app.LocationItemView()

        it "is an instance of a Backbone view", ->
            @view.should.be.an.instanceof Backbone.View

        it "sets the model to null if id is updated.", ->
            @view.model = {}
            @view.id = 0
            @view.setId 1
            @view.model?.should.not.be.ok

        it "does not clear the model if the id remains the same", ->
            testModel = {foo: "bar"}
            @view.model = testModel
            @view.id = 0
            @view.setId 0
            @view.model.should.be.ok
            @view.model.foo.should.equal "bar"

        it "is able to render its template", ->
            model = new window.app.Location()
            model.attributes =
                NAME: "test"
                DAYS: "test"
                HOURS: "test"
                geometry: [0, 0]

            @view.template(model).should.be.ok

    describe "LocationRowView", ->
        beforeEach ->
            @view = new window.app.LocationRowView()

        it "is an instance of a Backbone view", ->
            @view.should.be.an.instanceof Backbone.View

        it "is able to render its template", ->
            model = new window.app.Location {id: 0}
            model.attributes =
                NAME: "test"
                LOCATION: "test"
                ADDRESS: "test"
                DISTANCE: 0.0
                hours: {}

            @view.template(model).should.be.ok

    describe "SearchView", ->
        beforeEach ->
            @view = new window.app.SearchView()

        it "is an instance of a Backbone view", ->
            @view.should.be.an.instanceof Backbone.View
