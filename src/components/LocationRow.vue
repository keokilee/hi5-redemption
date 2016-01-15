<template>
  <div @click='navigate(location)' class='location'>
    <h3>{{ location.fullName() }}</h3>
    <p>{{ location.getLocation() }}</p>
    <p>{{ addressLabel(location, coordinates) }}</p>
    <p class='location-hours'>{{ location.getTodaysHours() }}</p>
  </div>
</template>

<script>
export default {
  methods: {
    addressLabel (location, coordinates) {
      if (!coordinates) {
        return location.getAddress()
      }
      const { latitude, longitude } = coordinates
      const distance = Math.floor(location.getDistance(latitude, longitude) * 10) / 10
      return `${location.getAddress()} (${distance} miles)`
    }
  },
  props: [ 'location', 'coordinates' ]
}
</script>

<style scoped>
.location h3 {
  font-size: 20px;
  margin: 0;
  cursor: pointer;
}

.location p {
  font-size: 14px;
  margin: 5px 0;
}

.location-hours {
  font-weight: bold;
}
</style>
