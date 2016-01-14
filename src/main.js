/* global __DEBUG__:false */
import 'babel-polyfill'

import Vue from 'vue'

import App from 'src/App'
import router from 'src/router'

Vue.config.debug = __DEBUG__

router.start(App, 'body')
