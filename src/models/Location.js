export default class Location {
  constructor ({ attributes, geometry }) {
    Object.assign(this, {
      id: attributes.OBJECTID,
      name: attributes.ns1_name4,
      address: attributes.Address,
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

  hasWeekend () {
    this.WEEKEND !== ' '
  }

  getHours () {
    let hours = `Open ${this.attributes.DAYS} from ${this.attributes.HOURS}`
    if (this.hasWeekend()) {
      hours += `, ${this.attributes.WEEKEND} from ${this.attributes.WEEKEND_HO}`
    }

    return hours
  }

  getTodaysHours () {
    const date = new Date()
    const day = date.getDay()
    if (!this.attributes.hours[day]) {
      return 'Closed today'
    }

    return `Open today from ${this.openTime(date)} to ${this.closeTime(date)}`
  }

  openTime (date) {
    const day = date.getDay()

    if (!this.attributes.hours[day]) {
      return null
    }

    return parseTime(this.attributes.hours[day].open)
  }

  closeTime (date) {
    const day = date.getDay()

    if (!this.attributes.hours[day]) {
      return null
    }

    return parseTime(this.attributes.hours[day].close)
  }

  isOpen (date) {
    const day = date.getDay()
    if (!this.attributes.hours[day]) {
      return false
    }

    const timeInt = (date.getHours() * 100) + date.getMinutes()
    const open = this.attributes.hours[day].open
    const close = this.attributes.hours[day].close

    return timeInt > open && timeInt < close
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
 * Helper function for generating time format
 * @param  {Number} time The numerical time provided as an int (like 1900)
 * @return {String}      Time in the format HH:MM AM/PM
 */
function parseTime (time) {
  let ampm = 'AM'
  let hour = Math.floor(time / 100)
  let minutes = time - (hour * 100)

  if (hour === 0) {
    hour = 12
  } else if (hour === 12) {
    ampm = 'PM'
  } else if (hour > 12) {
    hour -= 12
    ampm = 'PM'
  }

  if (minutes < 10) {
    minutes = `0${minutes}`
  }

  return `${hour}:${minutes} ${ampm}`
}

/**
 * Convert degrees into radians
 * @param  {Number} degrees The degrees used for the location
 * @return {Number}         The radians for the location
 */
function radians (degrees) {
  return degrees * Math.PI / 180
}
