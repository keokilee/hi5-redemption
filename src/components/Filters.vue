<template lang="jade">
.filters
  p Show
    span.dropdown
      select(v-model='openValue', @change='openChange')
        option(value='{{ constants.ALL_LOCATIONS }}') all
        option(value='{{ constants.OPEN_LOCATIONS }}') open
        option(value='{{ constants.CLOSED_LOCATIONS }}') closed
    | centers
    span.dropdown
      select(v-model='distanceValue', @change='distanceChange')
        option(value='{{ constants.ALL_LOCATIONS }}') in the state
        option(value='5', v-if='hasCoordinates') within 5 miles
        option(value='10', v-if='hasCoordinates') within 10 miles

  p near
    search
</template>

<script>
import Search from 'src/components/Search'
import store from 'src/store'
import { setOpen, setDistance } from 'src/store/actions'
import { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'

export default {
  data () {
    return {
      distanceValue: ALL_LOCATIONS,
      openValue: ALL_LOCATIONS,
      constants: { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS }
    }
  },
  computed: {
    hasCoordinates: () => !!store.state.coordinates
  },
  methods: {
    openChange () {
      this.setOpen(this.openValue)
    },
    distanceChange () {
      let value = this.distanceValue
      if (this.distanceValue !== ALL_LOCATIONS) {
        value = +value
      }

      this.setDistance(value)
    }
  },
  components: { Search },
  vuex: {
    actions: {
      setOpen,
      setDistance
    }
  }
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
    margin-left: 7px;
  }
}
</style>
