<template lang="jade">
.root
  app-header(title='Recycling Centers')
  filters
  location-list(v-if='locations',
    :locations='locations',
    :coordinates='coordinates')
</template>

<script>
import store from 'src/store'
import { getLocation } from 'src/services/geolocation'

import Header from 'src/components/Header'
import Filters from 'src/components/Filters'
import LocationList from 'src/components/LocationList'

export default {
  ready: async function () {
    try {
      let [ latitude, longitude ] = await getLocation()
      store.actions.setLocation({ name: 'Current Location', latitude, longitude })
    } catch (e) {
      // Do not set a location.
      console.error(e)
    }
  },
  computed: {
    locations: () => store.state.recyclingCenters,
    coordinates: () => store.state.coordinates
  },
  components: {
    Filters,
    LocationList,
    'app-header': Header
  }
}
</script>
