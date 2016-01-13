<template>
  <div class='app'>
    <app-header></app-header>
    <filters></filters>
    <location-list :locations='locations' :coordinates='coordinates'></location-list>
  </div>
</template>

<script>
import store from 'src/store'

import Header from 'src/components/Header'
import Filters from 'src/components/Filters'
import LocationList from 'src/components/LocationList'

import { getLocation } from 'src/services/geolocation'

getLocation().then(([lat, lng]) => store.dispatch('SET_LOCATION', {
  latitude: lat,
  longitude: lng
}))

export default {
  computed: {
    locations: () => store.state.recyclingCenters,
    coordinates: () => store.state.coordinates
  },
  components: {
    'app-header': Header,
    Filters,
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
