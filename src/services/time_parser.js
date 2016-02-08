import moment from 'moment'

const DAYS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']

export default class HoursParser {
  openToday (hours, date = new Date()) {
    const currentDay = DAYS[moment(date).day()]
    const components = this._parseComponents(hours)

    return components.some(component => this._inDays(component, currentDay))
  }

  openNow (hours, date = new Date()) {
    const currentDay = DAYS[moment(date).day()]
    const components = this._parseComponents(hours)

    return components.some(component => {
      return this._inDays(component, currentDay) && this._inHours(component, date)
    })
  }

  _parseComponents (hours) {
    return hours.split(';').map(h => h.replace(/^\s+/, ''))
  }

  _inDays (hoursComponent, day) {
    const days = hoursComponent.split(' ')[0]

    if (days.indexOf('-') >= 0) {
      return this._inDayRange(days, day)
    } else {
      return this._inSpecifiedDay(days, day)
    }
  }

  _inHours (hoursComponent, date) {
    const hours = hoursComponent.split(' ')[1]
    const [start, end] = hours.split('-')
    const [startHours, startMinutes] = start.split(':').map(t => +t)
    const [endHours, endMinutes] = end.split(':').map(t => +t)

    const startDate = moment(date).hour(startHours).minutes(startMinutes)
    const endDate = moment(date).hour(endHours).minutes(endMinutes)

    return (startDate.isBefore(date) || startDate.isSame(date)) &&
            endDate.isAfter(date)
  }

  _inDayRange (daysString, day) {
    const [startDay, endDay] = daysString.split('-')
    const startIndex = DAYS.indexOf(startDay)
    const endIndex = DAYS.indexOf(endDay) + 1

    // If the range does not wrap, then we can handle this normally.
    if (startIndex < endIndex) {
      const days = DAYS.slice(startIndex, endIndex)
      return days.length === 7 || days.indexOf(day) >= 0
    } else {
      // We flip the range around and check that the day is NOT included
      const days = DAYS.slice(endIndex, startIndex)
      return days.indexOf(day) < 0
    }
  }

  _inSpecifiedDay (daysString, day) {
    return daysString.split(',').indexOf(day) >= 0
  }
}
