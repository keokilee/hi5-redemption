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
      <span class='search'>
        <input type='text' v-model='place' />
        <span class='bar'></span>
      </span>
    </p>
  </div>
</template>

<script>
import store from 'src/store'
import { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'

export default {
  data () {
    return {
      place: 'Current Location',
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
  }
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

.search {
  position: relative;
  margin: 25px 10px 25px 20px;
}

.search input {
  font-size: 16px;
  padding-bottom: 5px;
  display: inline-block;
  width: calc(100% - 60px);
  border: none;
  border-bottom: 1px solid #757575;
}

.search input:focus {
  outline: none;
}

.search input:focus ~ label {
  top: -20px;
  font-size: 0.9rem;
  color: #2979FF;
}

.search input:focus ~ .bar:before, .search input:focus ~ .bar:after {
  width: 50%;
}

.bar {
  position: relative;
  display: block;
  width: calc(100% - 60px);
}

.bar:before, .bar:after {
  content: '';
  height: 2px;
  width: 0;
  bottom: 4px;
  position: absolute;
  background: #2979FF;
  transition: 0.2s ease all;
}

.bar:before {
  left: calc(50% + 55px);
}

.bar:after {
  right: calc(50% - 55px);
}
</style>
