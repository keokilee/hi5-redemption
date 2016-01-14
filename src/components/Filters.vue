<template>
  <div class="filters">
    <p>
      Show
      <span class="dropdown">
        <select v-model='openValue' @change='openChange'>
          <option value="{{ constants.ALL_LOCATIONS }}">all</option>
          <option value="{{ constants.OPEN_LOCATIONS }}">open</option>
          <option value="{{ constants.CLOSED_LOCATIONS }}">closed</option>
        </select>
      </span>
      redemption centers
      <span class="dropdown">
        <select v-model='distanceValue' @change='distanceChange'>
          <option value="{{ constants.ALL_LOCATIONS }}">on O`ahu</option>
          <option value="5">within 5 miles</option>
          <option value="10">within 10 miles</option>
        </select>
      </span>
    </p>
    <p>
      near
      <search></search>
    </p>
  </div>
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
  font-size: 16px;
}

.filters p {
  margin: 0;
  line-height: 2.4rem;
}

.dropdown {
  padding-bottom: 3px;
  border-bottom: 1px solid #2979FF;
}

.dropdown select {
  display: inline-block;
  font-family: inherit;
  background-color: transparent;
  border: none;
  font-size: inherit;
  border-radius: 0;
}
</style>
