<template lang="jade">
.app
  router-view
</template>

<script>
import store from 'src/store'

import { getLocation } from 'src/services/geolocation'

export default {
  replace: false,
  ready () {
    getLocation().then(([latitude, longitude]) => store.dispatch('SET_LOCATION', {
      name: 'Current Location',
      latitude,
      longitude
    }))
  }
}
</script>

<style>
body {
  font-family: Roboto, sans-serif;
  margin: 0;
  font-size: 10px;
  background-color: #FEFEFE;
}

a {
  text-decoration: none;
  color: #333;
}
</style>
