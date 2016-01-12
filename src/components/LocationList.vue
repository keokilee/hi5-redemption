<template>
  <ul class='{{ styles.locations }}'>
    <li v-for='location in locations'>
      <location-row :location='location' :coordinates='coordinates'></location-row>
    </li>
  </ul>
</template>

<script>
import styles from 'src/assets/locations.css'
import LocationRow from 'src/components/LocationRow'

export default {
  data () {
    return {
      styles
    }
  },
  props: [ 'locations', 'coordinates' ],
  components: { LocationRow }
}
</script>
