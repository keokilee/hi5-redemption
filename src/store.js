import Vuex from 'vuex'
import Vue from 'vue'

import Location from 'src/models/Location'
import locationData from 'src/data/locations.json'

const recyclingCenters = locationData.map(l => new Location(l))

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    recyclingCenters,
    coordinates: null
  },
  mutations: {
    SET_LOCATION (state, coordinates) {
      state.coordinates = coordinates
    }
  }
})

export default store
