import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
let router = new VueRouter()

router.map({
  '/': {
    component: (resolve) => require(['./components/RootView.vue'], resolve),
    name: 'root'
  },
  '/locations/:id': {
    component: (resolve) => require(['./components/LocationView.vue'], resolve),
    name: 'location'
  }
})

export default router
