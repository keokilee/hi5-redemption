<template>
  <div class='app'>
    <app-header></app-header>
    <search></search>
    <location-list></location-list>
  </div>
</template>

<script>
import Header from './components/Header'
import Search from './components/Search'
import LocationList from './components/LocationList'

export default {
  components: {
    'app-header': Header,
    Search,
    LocationList
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
