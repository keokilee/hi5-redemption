import Location from 'src/models/Location'

import { ALL_LOCATIONS, OPEN_LOCATIONS, CLOSED_LOCATIONS } from 'src/constants'

export default class LocationCollection {
  constructor (data) {
    this.data = data.map(l => new Location(l))
    this.openFilter = ALL_LOCATIONS
    this.distanceFilter = ALL_LOCATIONS
  }

  setOpenFilter (value) {
    this.openFilter = value
  }

  setDistanceFilter (value) {
    this.distanceFilter = value
  }

  sort (latitude, longitude) {
    return this.data.filter(openFilter(this.openFilter))
               .filter(distanceFilter(latitude, longitude, this.distanceFilter))
               .sort(sortByDistanceFrom(latitude, longitude))
  }
}

function openFilter (value) {
  const today = new Date()

  return location => {
    if (value === OPEN_LOCATIONS) {
      return location.isOpen(today)
    } else if (value === CLOSED_LOCATIONS) {
      return !location.isOpen(today)
    }

    return true
  }
}

function distanceFilter (latitude, longitude, value) {
  return location => {
    if (typeof value !== 'number') {
      return true
    }

    return location.getDistance(latitude, longitude) < value
  }
}

function sortByDistanceFrom (lat, lng) {
  return (location1, location2) => {
    if (location1.getDistance(lat, lng) < location2.getDistance(lat, lng)) {
      return -1
    }

    return 1
  }
}
