import moment from 'moment'

const DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

const FULL_DAYS = {
  'Sun': 'Sunday',
  'Mon': 'Monday',
  'Tue': 'Tuesday',
  'Wed': 'Wednesday',
  'Thu': 'Thursday',
  'Fri': 'Friday',
  'Sat': 'Saturday'
}

const TIME_FORMAT = 'h:mm a'
const TIME_REGEX = /\d{2}:\d{2}/g

export function fullHours (hours) {
  let formatted = mergeComponents(hours)
  // Insert a from between the days and the times.
  formatted = formatted.replace(/(\w{2}) (\d{2})/g, (_, day, hour) => {
    return `${day} from ${hour}`
  })

  // Add some space between commas and replace dashes with 'to'
  formatted = formatted.replace(/,/g, ', ').replace(/-/g, ' - ')

  // Process the days
  formatted = Object.keys(FULL_DAYS).reduce((str, shortDay) => {
    const re = new RegExp(shortDay, 'g')
    return str.replace(re, FULL_DAYS[shortDay])
  }, formatted)

  // Format the hours
  formatted = formatted.replace(TIME_REGEX, (match) => {
    return `${formatTime(match)}`
  })

  // Replace semicolons with new lines
  return formatted.replace(/;\s/g, '\n')
}

function mergeComponents (hours) {
  const components = _parseComponents(hours).reduce((acc, hourComponent) => {
    const [days, times] = hourComponent.split(' ')
    console.log(acc)
    acc[days] = acc[days] || []
    acc[days] = [...acc[days], times]

    return acc
  }, {})

  return Object.keys(components).map((days) => {
    return `${days} ${components[days].join(' and ')}`
  }).join('; ')
}

function formatTime (timeStr) {
  let [hours, minutes] = timeStr.split(':')
  hours = +hours
  let ampm = 'AM'

  if (hours > 12) {
    hours -= 12
    ampm = 'PM'
  } else if (hours === 12) {
    ampm = 'PM'
  }

  return `${hours}:${minutes} ${ampm}`
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
