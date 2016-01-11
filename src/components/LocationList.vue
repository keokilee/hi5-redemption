<template>
  <ul class='{{ styles.locations }}'>
    <li v-for='location in locations'>
      <location-row :location='location'></location-row>
    </li>
  </ul>
</template>

<script>
import styles from 'src/assets/locations.css'
import Location from 'src/models/Location'
import locationData from 'src/data/locations.json'
import LocationRow from 'src/components/LocationRow'

const locations = locationData.map(l => new Location(l))

export default {
  data () {
    return {
      styles,
      locations
    }
  },
  components: { LocationRow }
}
</script>
