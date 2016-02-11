import { OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'
import locationData from '../../data/data.json'
import Location from 'src/models/Location'

const locations = locationData.features
            .filter(l => l.attributes.Status !== 'CLOSED')
            .map(l => new Location(l))

export default {
  SET_LOCATION (state, { latitude, longitude, name }) {
    if (!state.defaultCoordinates) {
      state.defaultCoordinates = { latitude, longitude, name }
    }

    state.coordinates = { latitude, longitude, name }
    state.recyclingCenters = updateRecyclingCenters(state)
  },
  SET_OPEN (state, open) {
    state.filters = {
      ...state.filters,
      open
    }
    state.recyclingCenters = updateRecyclingCenters(state)
  },
  SET_DISTANCE (state, distance) {
    state.filters = {
      ...state.filters,
      distance
    }
    state.recyclingCenters = updateRecyclingCenters(state)
  },
  SET_CENTER (state, centerId) {
    state.selectedCenter = locations.filter(l => l.id === centerId)[0]
  }
}

function updateRecyclingCenters (state) {
  return locations.filter(openFilter(state.filters.open))
                  .filter(distanceFilter(state.coordinates, state.filters.distance))
                  .sort(sortByDistance(state.coordinates))
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
