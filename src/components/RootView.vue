<template>
  <div class="root">
    <app-header title='Recycling Centers'></app-header>
    <filters></filters>
    <location-list :locations='locations' :coordinates='coordinates'></location-list>
  </div>
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
