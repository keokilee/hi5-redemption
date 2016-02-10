<template lang="jade">
div(v-if='location')
  app-header(:title='location.name', back='/')
  .location-view
    .location-details
      p {{ location.address }}
      p {{ location.todaysHours() }}

    .location-map
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
  data () {
    return {
      location: null
    }
  },
  route: {
    data ({ to, next }) {
      next({
        location: store.state.recyclingCenters.filter(r => r.id === +to.params.id)[0]
      })
    }
  }
}
</script>

<style scoped>
.location-view {
  font-size: 16px;
}

.location-details {
  padding: 10px 20px;
  height: 80px;

  &.no-description {
    height: 50px;
  }
}

.location-map {
  height: calc(100vh - 240px);

  &.no-description {
    height: calc(100vh - 210px);
  }
}

.location-directions {
  text-align: center;
  height: 60px;

  & h3 {
    font-size: 22px;
    margin: 0;
    margin-top: 20px;
  }

  & a {
    display: inline-block;
    width: 100%;
    color: #2962FF;
  }
}
</style>
