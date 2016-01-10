<template>
  <div class='{{ styles.search }}'>
    <i class="material-icons">search</i>
    <input type='text' v-model='place'>
    <span class='{{ styles.highlight }}'></span>
    <span class='{{ styles.bar}}'></span>
  </div>
</template>

<script>
import styles from 'src/assets/search.css'

export default {
  data () {
    return {
      styles,
      place: ''
    }
  }
}
</script>
