<template lang="jade">
.app
  router-view
</template>

<script>
import store from 'src/store'

import { run, getLocation } from 'src/services/geolocation'

export default {
  replace: false,
  ready () {
    run(function *() {
      try {
        let [ latitude, longitude ] = yield getLocation()
        store.dispatch('SET_LOCATION', { name: 'Current Location', latitude, longitude })
      } catch (_) {
        // Use default location
        store.dispatch('SET_LOCATION', {
          name: 'Honolulu, HI',
          latitude: 21.3069444,
          longitude: -157.8583333
        })
      }
    })
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
