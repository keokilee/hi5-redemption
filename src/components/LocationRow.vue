<template lang="jade">
.location
  a(v-link="{name: 'location', params: { id: location.id }}")
    h3 {{ location.fullName() }}
    p {{ location.getLocation() }}
    p {{ addressLabel(location, coordinates) }}
    p
      strong {{ location.getTodaysHours() }}
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
.location {
  padding: 15px 20px 0;

  & a {
    display: inline-block;
    width: 100%;
  }

  & h3 {
    font-size: 22px;
    margin: 0;
    cursor: pointer;
  }

  & p {
    font-size: 16px;
    margin: 5px 0;
  }
}
</style>
