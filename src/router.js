import Vue from 'vue'
import VueRouter from 'vue-router'

import RootView from 'src/components/RootView'
import LocationView from 'src/components/LocationView'

Vue.use(VueRouter)
let router = new VueRouter()

router.map({
  '/': {
    component: RootView
  },
  '/locations/:id': {
    component: LocationView
  }
})

export default router
