<template>
  <div class='{{ styles.location }}'>
    <h3>{{ location.fullName() }}</h3>
    <p>{{ location.getLocation() }}</p>
    <p>{{ addressLabel(location, coordinates) }}</p>
    <p class='{{ styles.locationHours }}'>{{ location.getTodaysHours() }}</p>
  </div>
</template>

<script>
import styles from 'src/assets/locations.css'

export default {
  data () {
    return {
      styles
    }
  },
  methods: {
    addressLabel (location, coordinates) {
      if (!coordinates) {
        return location.getAddress()
      }
      const { latitude, longitude } = coordinates
      const distance = Math.floor(location.getDistance(latitude, longitude) * 10) / 10
      return `${location.getAddress()} (${distance} miles)`
    }
  },
  props: [ 'location', 'coordinates' ]
}
</script>
