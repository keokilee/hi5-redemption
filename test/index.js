// Polyfill fn.bind() for PhantomJS
/* eslint-disable no-extend-native */
Function.prototype.bind = require('function-bind')

const testsContext = require.context('.', true, /_spec$/)
testsContext.keys().forEach(testsContext)

const appContext = require.context('../src/', true, /(\.js|\.vue)$/)
appContext.keys().forEach(appContext)
