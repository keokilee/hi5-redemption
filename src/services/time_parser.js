import moment from 'moment'

const DAYS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']

export default class HoursParser {
  openToday (hours, date = new Date()) {
    const currentDay = DAYS[moment(date).day()]
    const components = hours.split(';').map(h => h.replace(/^\s+/, ''))

    return components.some(component => {
      const days = component.split(' ')[0]
      return this._inDays(days, currentDay)
    })
  }

  _inDays (daysString, day) {
    if (daysString.indexOf('-') >= 0) {
      return this._inDayRange(daysString, day)
    } else {
      return this._inSpecifiedDay(daysString, day)
    }
  }

  _inDayRange (daysString, day) {
    const [startDay, endDay] = daysString.split('-')
    const startIndex = DAYS.indexOf(startDay)
    const endIndex = DAYS.indexOf(endDay) + 1

    if (startIndex < endIndex) {
      // If the range does not wrap, then we can handle this normally.
      return DAYS.slice(startIndex, endIndex).indexOf(day) >= 0
    } else {
      // We flip the range around and check that the day is NOT included
      return DAYS.slice(endIndex, startIndex).indexOf(day) < 0
    }
  }

  _inSpecifiedDay (daysString, day) {
    return daysString.split(',').indexOf(day) >= 0
  }
}
