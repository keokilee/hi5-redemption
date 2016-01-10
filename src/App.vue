<template>
  <div class='app'>
    <app-header></app-header>
    <search></search>
  </div>
</template>

<script>
import Header from './components/Header'
import Search from './components/Search'

export default {
  components: {
    'app-header': Header,
    Search
  }
}
</script>

<style>
body {
  font-family: Roboto, sans-serif;
  margin: 0;
  font-size: 10px;
}
</style>
