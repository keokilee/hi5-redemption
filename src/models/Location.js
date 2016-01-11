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

export default class Location {
  constructor (location) {
    this.attributes = location
    this.id = location.ID
  }

  fullName () {
    let name = this.attributes.NAME
    if (this.attributes.COMPANY !== ' ') {
      name += ` - ${this.attributes.COMPANY}`
    }

    return name
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

  getDescription () {
    return this.attributes.DESCRIPTIO
  }

  getLocation () {
    return this.attributes.LOCATION
  }

  getAddress () {
    return this.attributes.ADDRESS
  }
}
