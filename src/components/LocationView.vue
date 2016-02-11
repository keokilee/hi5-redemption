<template lang="jade">
div(v-if='location')
  app-header(:title='location.name', back='/')
  .location-view
    .location-details
      p {{ location.address }}
      p {{ location.todaysHours() }}

    map(:latitude="location.geometry.y", :longitude="location.geometry.x", keep-alive)

    .location-directions
      h3
        a(target="_blank", href="{{ location.mapsLink() }}") Get Directions
</template>

<script>
import Header from 'src/components/Header'
import Map from 'src/components/Map'

import store from 'src/store'

export default {
  components: {
    'app-header': Header,
    Map
  },
  computed: {
    location: () => store.state.selectedCenter
  },
  route: {
    data ({ to, next }) {
      store.dispatch('SET_CENTER', +to.params.id)
      next()
    }
  }
}
</script>

<style scoped>
.location-view {
  font-size: 16px;
  display: flex;
  flex-direction: column;
  height: calc(100vh - 64px);
}

.location-details {
  padding: 10px 20px;
}

.location-directions {
  text-align: center;

  & h3 {
    font-size: 22px;
    margin: 20px 0;
  }

  & a {
    display: inline-block;
    width: 100%;
    color: #2962FF;
  }
}
</style>
