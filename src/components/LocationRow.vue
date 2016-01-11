<template>
  <div class='{{ styles.location }}'>
    <h3>{{ title(location) }}</h3>
    <p>{{ location.LOCATION }}</p>
    <p>{{ location.ADDRESS }}</p>
  </div>
</template>

<script>
import styles from 'src/assets/locations.css'

function title (location) {
  let title = location.NAME
  if (location.COMPANY && location.COMPANY.length > 1) {
    title += ` - ${location.COMPANY}`
  }

  return title
}

export default {
  data () {
    return {
      styles,
      title
    }
  },
  props: [ 'location' ]
}
</script>
