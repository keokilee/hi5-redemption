<template>
  <div class='location-view'>
    <div class="location-details">
      <h3>{{ location.fullName() }}</h3>
      <p>{{ location.getHours() }}</p>
      <p>{{ location.getDescription() }}</p>
    </div>
    <div id='map'>
    </div>
  </div>
</template>

<script>
import store from 'src/store'

import MapsLoader from 'src/services/google_maps'

export default {
  ready () {
    MapsLoader.load().then(google => {
      const coords = {
        lat: this.location.attributes.geometry[1],
        lng: this.location.attributes.geometry[0]
      }

      this.map = new google.maps.Map(document.getElementById('map'), {
        center: coords,
        zoom: 17
      })

      this.marker = new google.maps.Marker({
        position: coords,
        map: this.map
      })
    })
  },
  data () {
    return {
      location: store.state.recyclingCenters.filter(r => r.id !== this.$route.params.id)[0]
    }
  }
}
</script>

<style scoped>
.location-details {
  padding: 0 20px;
}

.location-details h3 {
  font-size: 22px;
}

.location-details p {
  font-size: 16px;
}

#map {
  height: 70vh;
}
</style>
