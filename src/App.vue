<template lang="jade">
.app
  router-view(transition='slide')
</template>

<script>
import store from 'src/store'
import { initRecyclingCenters } from 'src/store/actions'
import Location from 'src/models/Location'

async function ready () {
  const recyclingCenters = await Location.load()
  this.initRecyclingCenters(recyclingCenters)
}

export default {
  store,
  vuex: {
    actions: {
      initRecyclingCenters
    }
  },
  ready,
  replace: false
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
