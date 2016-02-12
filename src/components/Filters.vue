<template lang="jade">
.filters
  p Show
    span.dropdown
      select(v-model='openValue', @change='openChange')
        option(value='{{ constants.ALL_LOCATIONS }}') all
        option(value='{{ constants.OPEN_LOCATIONS }}') open
        option(value='{{ constants.CLOSED_LOCATIONS }}') closed
    | redemption centers
    span.dropdown
      select(v-model='distanceValue', @change='distanceChange')
        option(value='{{ constants.ALL_LOCATIONS }}') in the state
        option(value='5') within 5 miles
        option(value='10') within 10 miles

  p near
    search
</template>

<script>
import Search from 'src/components/Search'
import store from 'src/store'
import { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'

export default {
  data () {
    return {
      distanceValue: ALL_LOCATIONS,
      openValue: ALL_LOCATIONS,
      constants: { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS }
    }
  },
  methods: {
    openChange () {
      store.dispatch('SET_OPEN', this.openValue)
    },
    distanceChange () {
      let value = this.distanceValue
      if (this.distanceValue !== ALL_LOCATIONS) {
        value = +value
      }

      store.dispatch('SET_DISTANCE', value)
    }
  },
  components: { Search }
}
</script>

<style scoped>
.filters {
  padding: 10px 20px 0;

  & p {
    margin: 0;
    line-height: 2.0rem;
  }
}

.dropdown {
  padding-bottom: 3px;
  border-bottom: 1px solid #2979FF;

  & select {
    display: inline-block;
    font-family: inherit;
    background-color: transparent;
    border: none;
    font-size: inherit;
    border-radius: 0;
    -webkit-appearance: none;
  }
}
</style>
