$ ->
    SearchView = Backbone.View.extend
        el: $('#searchView')
        initialize: ->
            this.input = this.$('#searchField')

            defaultBounds = new google.maps.LatLngBounds(
                new google.maps.LatLng(21.3111981, -157.8405013),
                new google.maps.LatLng(21.2711981, -157.8005013)
            )

            options =
                bounds: defaultBounds,
                componentRestrictions: {country: 'us'}

            autocomplete = new google.maps.places.Autocomplete this.input.get(0), options

    App = new SearchView;
