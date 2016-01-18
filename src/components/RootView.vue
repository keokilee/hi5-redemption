<template lang="jade">
div.root
  app-header(title='Recycling Centers')
  filters
  location-list(:locations='locations', :coordinates='coordinates')
</template>

<script>
import store from 'src/store'
import Header from 'src/components/Header'
import Filters from 'src/components/Filters'
import LocationList from 'src/components/LocationList'

export default {
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
