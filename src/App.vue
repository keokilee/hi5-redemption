<template lang="jade">
.app
  router-view
</template>

<script>
import store from 'src/store'

import { getLocation } from 'src/services/geolocation'

export default {
  replace: false,
  ready: async function () {
    try {
      let [ latitude, longitude ] = await getLocation()
      store.dispatch('SET_LOCATION', { name: 'Current Location', latitude, longitude })
    } catch (_) {
      // Use default location
      store.dispatch('SET_LOCATION', {
        name: 'Honolulu, HI',
        latitude: 21.3069444,
        longitude: -157.8583333
      })
    }
  }
}
</script>

<style>
body {
  font-family: Roboto, sans-serif;
  margin: 0;
  font-size: 16px;
  background-color: #FEFEFE;
}

h1 {
  font-size: 2.0rem;
}

h2 {
  font-size: 1.625rem;
}

h3 {
  font-size: 1.375rem;
}

p {
  font-size: 1.0rem;
  line-height: 1.25rem;
}

a {
  text-decoration: none;
  color: #333;
}
</style>
