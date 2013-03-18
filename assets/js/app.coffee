########## Models and Collections ################

Location = Backbone.Model.extend
    initialize: ->
        if @attributes? and @attributes.OBJECTID?
            @id = @attributes.OBJECTID

    url: ->
        return "/locations/" + @id

LocationCollection = Backbone.Collection.extend
    model: Location
    url: "/locations/"

Locations = new LocationCollection

########### Views ################

LocationItemView = Backbone.View.extend
    el: $('#locationView')

    setId: (id) ->
        @model = null
        @id = id

    renderMap: ->
        # If the map is already available, we recenter and move the marker.
        coords = new google.maps.LatLng(@model.attributes.geometry[1], @model.attributes.geometry[0])
        if @map?
            @map.setCenter coords
            @marker.setPosition coords

        else
            @map = new google.maps.Map document.getElementById('map'), {
                center: coords
                zoom: 17
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            @marker = new google.maps.Marker {
                position: coords
                map: @map
            }

    renderModel: ->
        attrs = @model.attributes
        @$('h1').html attrs.NAME

        # Create a description of the hours.
        details = "<p>Open #{attrs.DAYS} from #{attrs.HOURS}"
        details += ", #{attrs.WEEKEND} from #{attrs.WEEKEND_HO}" if attrs.WEEKEND != " "
        details += "</p>"
        if attrs.DESCRIPTIO != " "
            details += "<p>#{attrs.DESCRIPTIO}</p>"

        # Generate the link to get directions.
        details += "<p><a href='http://maps.google.com/maps?daddr=#{attrs.geometry[1]},#{attrs.geometry[0]}&hl=en' data-role='button'>Get directions</a></p>"
        @$('#details').html details
        @renderMap()

        # Need to do this to render the button.
        @$el.trigger('pagecreate')

        return this

    render: ->
        location = new Location {id: @id}
        location.fetch {
            success: (model, response) =>
                @model = model
                @renderModel()
        }

        return this

LocationRowView = Backbone.View.extend
    tagName: 'li'
    template: _.template $('#locationTemplate').html()

    render: ->
        attrs = @model.toJSON()
        # Show the company's name if available.
        attrs.NAME += " (#{attrs.COMPANY})" if attrs.COMPANY != " "

        @$el.html @template(attrs)
        return this

ResultView = Backbone.View.extend
    el: $('#resultView')

    initialize: ->
        # Clear the list of results
        @$el.empty()

        Locations.fetch {
            data: {
                lat: @options.lat
                long: @options.long
            }

            success: (collection, response) =>
                @collection = collection
                @render()
        }

        @render()

    render: ->
        if @collection?
            # Clear loading text.
            @$el.empty()

            @collection.each (location) =>
                view = new LocationRowView {model: location}
                @$el.append view.render().el
        else
            @$el.append '<li>Loading</li>'

        # Rerender the list view to get the jQuery Mobile stylings.
        @$el.listview 'refresh'
        return this

SearchView = Backbone.View.extend
    el: $('#searchView')
    initialize: ->
        @initializeSearchBox @$('input[type=text]')

    initializeSearchBox: (searchBox) ->
        # Default bounds for Honolulu
        defaultBounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(20.3111981, -158.8405013),
            new google.maps.LatLng(22.2711981, -156.8005013)
        )

        options =
            bounds: defaultBounds
            radius: 200
            componentRestrictions: {country: 'us'}

        autocomplete = new google.maps.places.Autocomplete searchBox.get(0), options

        # Set up a place changed listener for the box.
        google.maps.event.addListener autocomplete, 'place_changed', =>
            place = autocomplete.getPlace()
            if place.geometry
                @getResults place.geometry.location.mb, place.geometry.location.nb
            else
                @selectFirstResult()

    events:
        'click #location-button': 'requestLocation'
        'click #about': 'aboutPopup'

    # Select first place. Thanks Mubix.
    # http://stackoverflow.com/questions/10772282/google-maps-places-api-v3-autocomplete-select-first-option-on-enter-and-have?lq=1
    selectFirstResult: ->
        firstResult = $('.pac-container .pac-item:first').text()
        @$('input[type=text]').val firstResult
        geocoder = new google.maps.Geocoder()
        geocoder.geocode {"address": firstResult}, (results, status) =>
            if status == google.maps.GeocoderStatus.OK
                @getResults results[0].geometry.location.lat(), results[0].geometry.location.lng()

    aboutPopup: (event) ->
        @$("#about-popup").popup "open", {
            transition: 'pop'
            positionTo: 'window'
        }

    requestLocation: (event) ->
        navigator.geolocation.getCurrentPosition (position) =>
            @$('input[type=text]').val "Current Location"
            @getResults position.coords.latitude, position.coords.longitude

    getResults: (latitude, longitude) ->
        @$('#welcome').hide()
        resultView = new ResultView {lat: latitude, long: longitude}

########## Router ##############
AppRouter = Backbone.Router.extend
    routes:
        "": "search"
        "locations/:id": "showLocation"

    initialize: ->
        # Handle click in back button.
        # Delegated event handler because the button does not exist when called.
        $("div[data-role=header]").on 'click', "a[data-rel=back]", (event) ->
            window.history.back()
            false

        @firstPage = true

        # Save these so that we don't keep rendering them.
        @searchView = new SearchView()
        @locationView = new LocationItemView()

    changePage: (page) ->
        transition = $.mobile.defaultPageTransition
        if @firstPage
            transition = 'none'
            @firstPage = false

        $rendered = $(page.render().el)
        $.mobile.changePage $rendered, {changeHash: false, transition: transition}

        # Needed to rerender page. Page doesn't rerender the second time it is clicked.
        $rendered.trigger('pagecreate')

    search: ->
        @changePage(@searchView)

    showLocation: (id) ->
        @locationView.setId id
        @changePage(@locationView)

######### Entry point #########
$(document).ready ->
    router = new AppRouter()
    Backbone.history.start()

    $("#about-popup").popup()
