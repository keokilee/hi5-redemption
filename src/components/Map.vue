<template>
  <div id="map"></div>
</template>

<script>
import MapsLoader from 'src/services/google_maps'

export default {
  ready () {
    if (!this.latitude && !this.longitude) {
      return
    }

    MapsLoader.load().then(google => {
      const coords = {
        lat: this.latitude,
        lng: this.longitude
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
  props: [ 'latitude', 'longitude' ]
}
</script>

<style>
#map {
  height: 100%;
}
</style>
