import Vuex from 'vuex'
import Vue from 'vue'

import mutations from 'src/store/mutations'
import { ALL_LOCATIONS } from 'src/constants'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    filters: {
      open: ALL_LOCATIONS,
      distance: ALL_LOCATIONS
    },
    recyclingCenters: null,
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
