<template>
  <div @click='navigate(location)' class='location'>
    <a v-link="{name: 'location' , params: { id: location.id }}">
      <h3>{{ location.fullName() }}</h3>
      <p>{{ location.getLocation() }}</p>
      <p>{{ addressLabel(location, coordinates) }}</p>
      <p class='location-hours'>{{ location.getTodaysHours() }}</p>
    </a>
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
    },
    navigate (location) {
      this.$router.go({ path: `/locations/${location.id}` })
    }
  },
  props: [ 'location', 'coordinates' ]
}
</script>

<style scoped>
.location {
  padding: 15px 20px 0;
}

.location a {
  display: inline-block;
}

.location h3 {
  font-size: 22px;
  margin: 0;
  cursor: pointer;
}

.location p {
  font-size: 16px;
  margin: 5px 0;
}

.location-hours {
  font-weight: bold;
}
</style>
