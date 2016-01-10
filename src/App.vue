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
@import url(https://fonts.googleapis.com/css?family=Roboto);

body {
  font-family: Roboto, sans-serif;
  margin: 0;
  font-size: 10px;
}
</style>
