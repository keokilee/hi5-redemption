<template lang="jade">
.root
  app-header(title='Recycling Centers')
  filters
  location-list(v-if='locations',
    :locations='locations',
    :coordinates='coordinates')
</template>

<script>
import { setLocation, setCenter } from 'src/store/actions'
import { getLocation } from 'src/services/geolocation'

import Header from 'src/components/Header'
import Filters from 'src/components/Filters'
import LocationList from 'src/components/LocationList'

export default {
  ready: async function () {
    this.setCenter(null)
    try {
      let [ latitude, longitude ] = await getLocation()
      this.setLocation({ name: 'Current Location', latitude, longitude })
    } catch (e) {
      // Do not set a location.
      console.error(e)
    }
  },
  computed: {
    locations () {
      return this.$store.state.recyclingCenters
    }
  },
  vuex: {
    getters: {
      coordinates: ({ coordinates }) => coordinates
    },
    actions: {
      setLocation,
      setCenter
    }
  },
  components: {
    Filters,
    LocationList,
    'app-header': Header
  }
}
</script>
