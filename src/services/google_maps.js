/* global __MAPS_KEY__:false */
import MapsLoader from 'google-maps'

MapsLoader.KEY = __MAPS_KEY__
MapsLoader.LIBRARIES = ['places']

// Store reference to google library
let _google

export default {
  load () {
    if (!_google) {
      _google = new Promise(resolve => {
        MapsLoader.load(google => resolve(google))
      })
    }

    return _google
  }
}
