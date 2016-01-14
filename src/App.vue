<template>
  <div class='app'>
    <app-header></app-header>
    <router-view></router-view>
  </div>
</template>

<script>
import store from 'src/store'

import Header from 'src/components/Header'
import { getLocation } from 'src/services/geolocation'

getLocation().then(([latitude, longitude]) => store.dispatch('SET_LOCATION', {
  name: 'Current Location',
  latitude,
  longitude
}))

export default {
  replace: false,
  components: {
    'app-header': Header
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
