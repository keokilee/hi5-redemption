import { OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'
import Location from 'src/models/Location'

// TODO: Overkill for now, but locations may be async loaded in the future.
const locations = new Promise((resolve) => {
  require.ensure([], (require) => {
    let data = require('../../data/data.json')
    const locations = data.features
      .filter(l => l.attributes.Status !== 'CLOSED')
      .map(l => new Location(l))

    resolve(locations)
  })
})

export default {
  SET_LOCATION (state, { latitude, longitude, name }) {
    if (!state.defaultCoordinates) {
      state.defaultCoordinates = { latitude, longitude, name }
    }

    state.coordinates = { latitude, longitude, name }
    updateRecyclingCenters(state)
  },
  SET_OPEN (state, open) {
    state.filters = {
      ...state.filters,
      open
    }
    updateRecyclingCenters(state)
  },
  SET_DISTANCE (state, distance) {
    state.filters = {
      ...state.filters,
      distance
    }
    updateRecyclingCenters(state)
  },
  SET_CENTER (state, centerId) {
    locations.then(locs => {
      state.selectedCenter = locs.filter(l => l.id === centerId)[0]
    })
  }
}

function updateRecyclingCenters (state) {
  return locations.then(locs => {
    state.recyclingCenters = locs.filter(openFilter(state.filters.open))
      .filter(distanceFilter(state.coordinates, state.filters.distance))
      .sort(sortByDistance(state.coordinates))
  })
}

function openFilter (value) {
  const today = new Date()

  return l => {
    if (value === OPEN_LOCATIONS) {
      return l.isOpen(today)
    } else if (value === CLOSED_LOCATIONS) {
      return !l.isOpen(today)
    }

    return true
  }
}

function distanceFilter ({ latitude, longitude }, value) {
  return l => {
    if (typeof value !== 'number') {
      return true
    }

    return l.getDistance(latitude, longitude) < value
  }
}

function sortByDistance ({ latitude, longitude }) {
  return (l1, l2) => {
    if (l1.getDistance(latitude, longitude) < l2.getDistance(latitude, longitude)) {
      return -1
    }

    return 1
  }
}
