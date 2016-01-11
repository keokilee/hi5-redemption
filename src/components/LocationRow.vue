<template>
  <div class='{{ styles.location }}'>
    <h3>{{ location.fullName() }}</h3>
    <p>{{ location.getLocation() }}</p>
    <p>{{ location.getAddress() }}</p>
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
  props: [ 'location' ]
}
</script>
