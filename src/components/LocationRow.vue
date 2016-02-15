<template lang="jade">
.location
  a(v-link="{name: 'location', params: { id: location.id }}")
    h3 {{ location.name }}
    p {{ location.siteAddress }}
    p {{ distanceLabel() }}
    p
      strong {{ location.todaysHours() }}
</template>

<script>
export default {
  methods: {
    distanceLabel () {
      if (this.coordinates) {
        const { latitude, longitude } = this.coordinates
        const distance = Math.floor(this.location.getDistance(latitude, longitude) * 10) / 10
        return `${distance} miles away`
      }

      return ''
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
