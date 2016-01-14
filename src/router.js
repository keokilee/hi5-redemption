import Vue from 'vue'
import VueRouter from 'vue-router'

import RootView from 'src/components/RootView'

Vue.use(VueRouter)
let router = new VueRouter()

router.map({
  '/': {
    component: RootView
  }
})

export default router
