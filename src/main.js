/* global __DEBUG__:false */
import Vue from 'vue'
import App from './App'

Vue.config.debug = __DEBUG__

/* eslint-disable no-new */
new Vue({
  el: 'body',
  replace: false,
  template: '<app></app>',
  components: { App }
})
