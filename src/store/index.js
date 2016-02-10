import Vuex from 'vuex'
import Vue from 'vue'

import mutations from 'src/store/mutations'
import { ALL_LOCATIONS } from 'src/constants'

import locationData from '../../data/data.json'
import Location from 'src/models/Location'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    filters: {
      open: ALL_LOCATIONS,
      distance: ALL_LOCATIONS
    },
    recyclingCenters: locationData.features
                      .filter(l => l.attributes.STATUS !== 'CLOSED')
                      .map(l => new Location(l)),
    defaultCoordinates: null,
    coordinates: null
  },
  mutations
})

export default store

if (module.hot) {
  // accept actions and mutations as hot modules
  module.hot.accept(['./mutations'], () => {
    // require the updated modules
    // have to add .default here due to babel 6 module output
    const newMutations = require('./mutations').default
    // swap in the new actions and mutations
    store.hotUpdate({
      mutations: newMutations
    })
  })
}
