import Vuex from 'vuex'
import Vue from 'vue'

import mutations from 'src/store/mutations'
import actions from 'src/store/actions'
import { ALL_LOCATIONS } from 'src/constants'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    filters: {
      open: ALL_LOCATIONS,
      distance: ALL_LOCATIONS
    },
    recyclingCenters: [],
    selectedCenter: null,
    defaultCoordinates: null,
    coordinates: null
  },
  actions,
  mutations
})

export default store

if (module.hot) {
  // accept actions and mutations as hot modules
  module.hot.accept(['./actions', './mutations'], () => {
    // require the updated modules
    // have to add .default here due to babel 6 module output
    const newMutations = require('./mutations').default
    const newActions = require('./actions').default
    // swap in the new actions and mutations
    store.hotUpdate({
      mutations: newMutations,
      actions: newActions
    })
  })
}
