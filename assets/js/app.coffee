########## Models and Collections ################

Location = Backbone.Model.extend
    initialize: ->
        if @attributes? and @attributes.OBJECTID?
            @id = @attributes.OBJECTID

    url: ->
        return "/locations/" + @id

LocationCollection = Backbone.Collection.extend
    model: Location
    baseUrl: "/locations/"
    search: (options, queryObj) ->
        # fetch uses @url, so we build url from the base url.
        @url = @baseUrl
        @url = @url + "?" + $.param(queryObj) if queryObj?
        @fetch options

Locations = new LocationCollection

########### Views ################

LocationItemView = Backbone.View.extend
    el: $('#locationView')
    template: _.template $('#detailTemplate').html()
    initialize: ->
        @model = @options.model

    render: ->
        @$el.html @template(@model.attributes)
        return this

LocationRowView = Backbone.View.extend
    tagName: 'li'
    template: _.template $('#locationTemplate').html()

    render: ->
        @$el.html @template(@model.toJSON())
        return this

ResultView = Backbone.View.extend
    el: $('#resultView')
    initialize: ->
        # Clear the list of results
        @$el.empty()

        Locations.search {
            success: (collection, response) =>
                @collection = collection
                @render()
        },
        {lat: @options.lat, long: @options.long}

    render: ->
        @collection.each (location) =>
            console.log location
            view = new LocationRowView {model: location}
            @$el.append view.render().el
            # Rerender the list view to get the jQuery Mobile stylings.
            @$el.listview 'refresh'

SearchView = Backbone.View.extend
    el: $('#searchView')
    initialize: ->
        @initializeSearchBox @$('input[type=text]')

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
            @getResults place.geometry.location.Xa, place.geometry.location.Ya

    events:
        'click .ui-btn-right': 'requestLocation'

    requestLocation: (event) ->
        navigator.geolocation.getCurrentPosition (position) =>
            @$('input[type=text]').val "Current Location"
            @getResults position.coords.latitude, position.coords.longitude

    getResults: (latitude, longitude) ->
        resultView = new ResultView {lat: latitude, long: longitude}

########## Router ##############
AppRouter = Backbone.Router.extend
    routes:
        "": "search"
        "locations/:id": "showLocation"

    initialize: ->
        # Handle click in back button.
        $("a[data-rel=back]").live 'click', (event) ->
            window.history.back()
            false

        @firstPage = true

    changePage: (page) ->
        transition = $.mobile.defaultPageTransition
        if @firstPage
            transition = 'none'
            @firstPage = false

        $.mobile.changePage $(page.render().el), {changeHash: false, transition: transition}
        # Needed to rerender page. Page doesn't rerender the second time it is clicked.
        $(page.render().el).trigger('pagecreate')

    search: ->
        @changePage(new SearchView())

    showLocation: (id) ->
        location = new Location {id: id}
        location.fetch {
            success: (model, response) =>
                @changePage(new LocationItemView({model: model}))
        }

######### Entry point #########
$(document).ready ->
    router = new AppRouter()
    Backbone.history.start()

