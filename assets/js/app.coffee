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
            console.log place.geometry
            this.setLocation place.geometry.location.Xa, place.geometry.location.Ya

            # Uncheck the current location checkbox
            if this.$('input[type=checkbox]').is(':checked')
                this.$("input[type='checkbox']").attr("checked", false).checkboxradio("refresh");

    events:
        'click .ui-btn-right': 'requestLocation'

    requestLocation: (event) ->
        navigator.geolocation.getCurrentPosition (position) =>
            this.$('input[type=text]').prop 'placeholder', 'Current Location'
            this.setLocation position.coords.latitude, position.coords.longitude

    setLocation: (latitude, longitude) ->
        $("input[name=latitude]").val latitude
        $("input[name=longitude]").val longitude

$ ->
    App = new SearchView

