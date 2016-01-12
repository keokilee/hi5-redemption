import Vuex from 'vuex'
import Vue from 'vue'

import Location from 'src/models/Location'
import locationData from 'src/data/locations.json'

let recyclingCenters = locationData.map(l => new Location(l))

Vue.use(Vuex)

function sortByDistanceFrom (lat, lng) {
  return (location1, location2) => {
    if (location1.getDistance(lat, lng) < location2.getDistance(lat, lng)) {
      return 1
    }

    return -1
  }
}

const store = new Vuex.Store({
  state: {
    recyclingCenters,
    coordinates: null
  },
  mutations: {
    SET_LOCATION (state, { latitude, longitude }) {
      state.coordinates = { latitude, longitude }
      state.recyclingCenters = state.recyclingCenters.sort(sortByDistanceFrom(latitude, longitude))
    }
  }
})

export default store
