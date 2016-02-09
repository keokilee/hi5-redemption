<template lang="jade">
.location
  a(v-link="{name: 'location', params: { id: location.id }}")
    h3 {{ location.name }}
    p {{ addressLabel() }}
    p
      strong {{ location.todaysHours() }}
</template>

<script>
export default {
  methods: {
    addressLabel () {
      if (!this.coordinates) {
        return this.location.siteAddress
      }
      const { latitude, longitude } = this.coordinates
      const distance = Math.floor(this.location.getDistance(latitude, longitude) * 10) / 10
      return `${this.location.siteAddress} (${distance} miles)`
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
    margin: 0;
    cursor: pointer;
  }

  & p {
    margin: 5px 0;
  }
}
</style>
