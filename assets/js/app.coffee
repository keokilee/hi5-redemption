Location = Backbone.Model

LocationView = Backbone.View.extend
    tagName: 'li'
    template: _.template($('#locationTemplate').html())
    render: ->
        this.$el.html(this.template(this.model.toJSON()))
        return this

LocationCollection = Backbone.Collection.extend
    model: Location
    url: "/locations/"
    search: (options, queryObj) ->
        baseUrl = "/locations/"
        if queryObj?
            this.url = this.url + "?" + $.param(queryObj)

        this.fetch(options)

Locations = new LocationCollection

ResultView = Backbone.View.extend
    el: $('#resultView')
    initialize: ->
        Locations.search {
            success: (collection, response) =>
                this.collection = collection
                this.render()
        },
        {lat: this.options.lat, long: this.options.long}

    render: ->
        this.collection.each (location) =>
            view = new LocationView {model: location}
            this.$el.append view.render().el
            this.$el.listview('refresh')

SearchView = Backbone.View.extend
    el: $('#searchView')
    initialize: ->
        this.initializeSearchBox this.$('input[type=text]')

    initializeSearchBox: (searchBox) ->
        # Default bounds for Honolulu
        defaultBounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(21.3111981, -157.8405013),
            new google.maps.LatLng(21.2711981, -157.8005013)
        )
        options =
            bounds: defaultBounds
            types: ['geocode']
            componentRestrictions: {country: 'us'}

        autocomplete = new google.maps.places.Autocomplete searchBox.get(0), options

        # Set up a place changed listener for the box.
        google.maps.event.addListener autocomplete, 'place_changed', =>
            place = autocomplete.getPlace()
            this.getResults place.geometry.location.Xa, place.geometry.location.Ya

    events:
        'click .ui-btn-right': 'requestLocation'

    requestLocation: (event) ->
        navigator.geolocation.getCurrentPosition (position) =>
            this.$('input[type=text]').prop 'placeholder', 'Current Location'
            this.getResults position.coords.latitude, position.coords.longitude

    getResults: (latitude, longitude) ->
        resultView = new ResultView {lat: latitude, long: longitude}


$ ->
    App = new SearchView

