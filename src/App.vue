<template>
  <div class='app'>
    <app-header></app-header>
    <search></search>
    <location-list :locations='locations'></location-list>
  </div>
</template>

<script>
import Header from 'src/components/Header'
import Search from 'src/components/Search'
import LocationList from 'src/components/LocationList'

import Location from 'src/models/Location'
import { getLocation } from 'src/services/geolocation'
import locationData from 'src/data/locations.json'

const locations = locationData.map(l => new Location(l))
getLocation().then(([lat, lng]) => console.log(`${lat},${lng}`))

export default {
  data () {
    return {
      locations
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
