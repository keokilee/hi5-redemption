<template>
  <div class={{styles.filters}}>
    <p>
      Show
      <span class="{{styles.dropdown}}">
        <select v-model='openValue' @change='openChange'>
          <option value="{{ constants.ALL_LOCATIONS }}">all</option>
          <option value="{{ constants.OPEN_LOCATIONS }}">open</option>
          <option value="{{ constants.CLOSED_LOCATIONS }}">closed</option>
        </select>
      </span>
      redemption centers
      <span class="{{styles.dropdown}}">
        <select v-model='distanceValue' @change='distanceChange'>
          <option value="{{ constants.ALL_LOCATIONS }}">on O`ahu</option>
          <option value="5">within 5 miles</option>
          <option value="10">within 10 miles</option>
        </select>
      </span>
    </p>
  </div>
</template>

<script>
import store from 'src/store'
import styles from 'src/assets/filters.css'
import { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'

export default {
  data () {
    return {
      distanceValue: ALL_LOCATIONS,
      openValue: ALL_LOCATIONS,
      constants: { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS },
      styles
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
