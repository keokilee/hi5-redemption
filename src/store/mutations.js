import LocationCollection from 'src/models/LocationCollection'

import locationData from 'src/data/locations.json'

const recyclingCenters = new LocationCollection(locationData)

export default {
  SET_LOCATION (state, { latitude, longitude }) {
    state.coordinates = { latitude, longitude }
    state.recyclingCenters = recyclingCenters.sort(latitude, longitude)
  },
  SET_OPEN (state, open) {
    state.filters = {
      ...state.filters,
      open
    }
  },
  SET_DISTANCE (state, distance) {
    state.filters = {
      ...state.filters,
      distance
    }
  }
}
