<template>
  <div id='app'>
    <app-header></app-header>
  </div>
</template>

<script>
import Header from './components/Header'

export default {
  components: {
    'app-header': Header
  }
}
</script>

<style>
body {
  font-family: Helvetica, sans-serif;
}
</style>
