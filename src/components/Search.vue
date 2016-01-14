<template>
  <span class='search'>
    <input id='placeAutocomplete' type='text' @focus='clearInput' @blur='resetInput' value='Current Location' />
    <span class='bar'></span>
  </span>
</template>

<script>
import store from 'src/store'
import MapsLoader from 'src/services/google_maps'

// Hold previous value in the input
let previousValue

export default {
  methods: {
    clearInput (event) {
      previousValue = event.target.value
      event.target.value = ''
    },
    resetInput (event) {
      event.target.value = previousValue
    }
  },
  ready () {
    MapsLoader.load().then(google => {
      const bounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(20.3111981, -158.8405013),
        new google.maps.LatLng(22.2711981, -156.8005013)
      )

      const el = document.getElementById('placeAutocomplete')

      const autocomplete = new google.maps.places.Autocomplete(
        el,
        { bounds, radius: 200, componentRestrictions: { country: 'us' } }
      )

      google.maps.event.addListener(autocomplete, 'place_changed', () => {
        const place = autocomplete.getPlace()
        const name = place.name
        const latitude = place.geometry.location.lat()
        const longitude = place.geometry.location.lng()

        el.blur()
        store.dispatch('SET_LOCATION', { latitude, longitude, name })
      })
    })
  }
}
</script>

<style scoped>
.search {
  position: relative;
  margin: 25px 10px 25px;
}

.search input {
  font-size: 14px;
  padding-bottom: 5px;
  display: inline-block;
  width: calc(100% - 60px);
  border: none;
  border-bottom: 1px solid #757575;
  text-overflow: ellipsis;
}

.search input:focus {
  outline: none;
}

.search input:focus ~ label {
  top: -20px;
  font-size: 0.9rem;
  color: #2979FF;
}

.search input:focus ~ .bar:before, .search input:focus ~ .bar:after {
  width: 50%;
}

.bar {
  position: relative;
  display: block;
  width: calc(100% - 60px);
}

.bar:before, .bar:after {
  content: '';
  height: 2px;
  width: 0;
  bottom: 4px;
  position: absolute;
  background: #2979FF;
  transition: 0.2s ease all;
}

.bar:before {
  left: calc(50% + 46px);
}

.bar:after {
  right: calc(50% - 46px);
}
</style>
