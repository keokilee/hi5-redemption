<template lang="jade">
ul.locations
  li(v-for='location in locations')
    location-row(:location='location', :coordinates='coordinates')
</template>

<script>
import LocationRow from 'src/components/LocationRow'

export default {
  props: [ 'locations', 'coordinates' ],
  components: { LocationRow }
}
</script>

<style scoped>
.locations {
  list-style: none;
  margin: 0;
  padding: 0;
}

.locations li {
  padding-bottom: 10px;
  border-bottom: 1px solid #CCC;

  &:first-child {
    padding-top: 0;
  }
}
</style>
