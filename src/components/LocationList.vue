<template>
  <ul class='locations'>
    <li v-for='location in locations' @click='navigate(location)'>
      <location-row :location='location' :coordinates='coordinates'></location-row>
    </li>
  </ul>
</template>

<script>
import LocationRow from 'src/components/LocationRow'

export default {
  props: [ 'locations', 'coordinates' ],
  components: { LocationRow },
  methods: {
    navigate (location) {
      this.$router.go({ path: `/locations/${location.id}` })
    }
  }
}
</script>

<style scoped>
.locations {
  list-style: none;
  margin: 0;
  padding: 0;
}

.locations li {
  padding: 15px 20px 10px;
  border-bottom: 1px solid #CCC;
}

.locations li:first-child {
  padding-top: 0;
}
</style>
