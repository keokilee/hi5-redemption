import Vue from 'vue'
import VueRouter from 'vue-router'

import RootView from 'src/components/RootView'
import LocationView from 'src/components/LocationView'

Vue.use(VueRouter)
let router = new VueRouter()

router.map({
  '/': {
    component: RootView,
    name: 'root'
  },
  '/locations/:id': {
    component: LocationView,
    name: 'location'
  }
})

export default router
