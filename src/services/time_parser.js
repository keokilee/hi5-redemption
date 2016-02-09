import moment from 'moment'

const DAYS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
const TIME_FORMAT = 'h:mm a'

export default class HoursParser {
}

export function openToday (hours, date = new Date()) {
  return _parseComponents(hours).some(component => _inDays(component, date))
}

export function openNow (hours, date = new Date()) {
  return _parseComponents(hours).some(component => {
    return _inDays(component, date) && _inHours(component, date)
  })
}

export function todaysHours (hours, date = new Date()) {
  if (!openToday(hours, date)) {
    return 'Closed today'
  }

  // Grab the matching component.
  const { start, end } = _parseComponents(hours)
                        .filter(c => _inDays(c, date))
                        .map(c => _startAndEndDates(c, date))[0]

  return `Open from ${start.format(TIME_FORMAT)} to ${end.format(TIME_FORMAT)}`
}

function _parseComponents (hours) {
  return hours.split(';').map(h => h.replace(/^\s+/, ''))
}

function _inDays (hoursComponent, date) {
  const day = DAYS[moment(date).day()]
  const days = hoursComponent.split(' ')[0]

  if (days.indexOf('-') >= 0) {
    return _inDayRange(days, day)
  } else {
    return _inSpecifiedDay(days, day)
  }
}

function _inHours (hoursComponent, date) {
  const { start, end } = _startAndEndDates(hoursComponent, date)

  return (start.isBefore(date) || start.isSame(date)) &&
          end.isAfter(date)
}

function _startAndEndDates (hoursComponent, date) {
  const hours = hoursComponent.split(' ')[1]
  const [start, end] = hours.split('-')
  const [startHours, startMinutes] = start.split(':').map(t => +t)
  const [endHours, endMinutes] = end.split(':').map(t => +t)

  return {
    start: moment(date).hour(startHours).minutes(startMinutes),
    end: moment(date).hour(endHours).minutes(endMinutes)
  }
}

function _inDayRange (daysString, day) {
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

function _inSpecifiedDay (daysString, day) {
  return daysString.split(',').indexOf(day) >= 0
}
