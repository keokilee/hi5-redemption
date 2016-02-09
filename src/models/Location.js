import { todaysHours } from '../services/time_parser'

export default class Location {
  constructor ({ attributes, geometry }) {
    Object.assign(this, {
      id: attributes.OBJECTID,
      name: attributes.ns1_name4,
      address: attributes.Address,
      siteAddress: attributes.Site_Address,
      location: attributes.Location,
      island: attributes.Island,
      county: attributes.County,
      hours: attributes.Days_and_Hours_of_Operation,
      geometry
    })
  }

  mapsLink () {
    return `http://maps.google.com/maps?daddr=${this.geometry.y},${this.geometry.x}&hl=en`
  }

  todaysHours () {
    return todaysHours(this.hours)
  }

  getDistance (lat, lng) {
    // BACKWARDS!!!
    let { x, y } = this.geometry
    let [ lng2, lat2 ] = [x, y]

    const R = 3959 // miles
    var dLat = radians(lat2 - lat)
    var dLon = radians(lng2 - lng)
    lat = radians(lat)
    lat2 = radians(lat2)

    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat) * Math.cos(lat2)
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    return R * c
  }
}

/**
 * Convert degrees into radians
 * @param  {Number} degrees The degrees used for the location
 * @return {Number}         The radians for the location
 */
function radians (degrees) {
  return degrees * Math.PI / 180
}
