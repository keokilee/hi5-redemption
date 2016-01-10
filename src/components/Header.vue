<template>
  <div class='{{ styles.header }}'>
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>
import styles from 'src/assets/header.css'

export default {
  data () {
    return {
      styles,
      msg: 'header'
    }
  }
}
</script>
