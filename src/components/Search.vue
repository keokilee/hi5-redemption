<template lang="jade">
span.search
  input#placeAutocomplete(type='text', @focus='clearInput', @blur='resetInput', value='Current Location')
  span.bar
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

        console.log(place.geometry.location.lat())
        console.log(place.geometry.location.lng())
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

  & input {
    font-size: 1.0rem;
    padding-bottom: 5px;
    display: inline-block;
    width: calc(100% - 5.5rem);
    border: none;
    border-bottom: 1px solid #757575;
    text-overflow: ellipsis;

    &:focus {
      outline: 0;
    }

    &:focus ~ label {
      top: -20px;
      color: #2979FF;
    }

    &:focus ~ .bar:before, &:focus ~ .bar:after {
      width: 50%;
    }
  }
}

.bar {
  position: relative;
  display: block;
  width: calc(100% - 60px);

  &:before, &:after {
    content: '';
    height: 2px;
    width: 0;
    bottom: 1px;
    position: absolute;
    background: #2979FF;
    transition: 0.2s ease all;
  }

  &:before {
    left: calc(50% + 32px);
  }

  &:after {
    right: calc(50% - 32px);
  }
}
</style>
