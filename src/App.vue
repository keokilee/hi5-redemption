<template>
  <div class='app'>
    <app-header></app-header>
    <search></search>
    <p>Showing all redemption centers within 10 miles of your location</p>
    <location-list :locations='locations'></location-list>
  </div>
</template>

<script>
import store from 'src/store'

import Header from 'src/components/Header'
import Search from 'src/components/Search'
import LocationList from 'src/components/LocationList'

import { getLocation } from 'src/services/geolocation'

getLocation().then(([lat, lng]) => store.dispatch('SET_LOCATION', {
  latitude: lat,
  longitude: lng
}))

export default {
  computed: {
    locations () {
      return store.state.recyclingCenters
    }
  },
  components: {
    'app-header': Header,
    Search,
    LocationList
  }
}
</script>

<style>
body {
  font-family: Roboto, sans-serif;
  margin: 0;
  font-size: 10px;
}
</style>
