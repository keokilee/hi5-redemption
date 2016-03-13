/* global __MAPS_KEY__:false */
// Store reference to google library
let _google

export default {
  load () {
    if (!_google) {
      _google = new Promise((resolve) => {
        require.ensure([], (require) => {
          const MapsLoader = require('google-maps')
          MapsLoader.KEY = __MAPS_KEY__
          MapsLoader.LIBRARIES = ['places']

          MapsLoader.load(resolve)
        })
      })
    }

    return _google
  }
}
