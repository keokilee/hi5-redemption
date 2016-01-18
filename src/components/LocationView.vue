<template lang="jade">
div(v-if='location')
  app-header(:title='location.fullName()', back='/')
  div.location-view
    div.location-details(:class="{ 'no-description': location.getDescription() === ' ' }")
      p {{ location.getHours() }}
      p {{ location.getDescription() }}

    div.location-map(:class="{ 'no-description': location.getDescription() === ' ' }")
      map(:latitude="this.location.attributes.geometry[1]", :longitude="this.location.attributes.geometry[0]", keep-alive)

    div.location-directions
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
