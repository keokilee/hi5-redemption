import Vuex from 'vuex'
import Vue from 'vue'

import LocationCollection from 'src/models/LocationCollection'
import locationData from 'src/data/locations.json'

const recyclingCenters = new LocationCollection(locationData)

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    filters: {
      open: LocationCollection.ALL,
      distance: LocationCollection.ALL
    },
    recyclingCenters: null,
    coordinates: null
  },
  mutations: {
    SET_LOCATION (state, { latitude, longitude }) {
      state.coordinates = { latitude, longitude }
      state.recyclingCenters = recyclingCenters.sort(latitude, longitude)
    },
    SET_OPEN (state, open) {
      state.filters = {
        ...state.filters,
        open
      }
    },
    SET_DISTANCE (state, distance) {
      state.filters = {
        ...state.filters,
        distance
      }
    }
  }
})

export default store
