# Whitespace trim function for strings.
String::trim = ->
    this.replace /^\s+|\s+$/, ""

daysArray = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
rangeRegex = new RegExp(/(\w{3}) - (\w{3})/)
commaRegex = new RegExp(/(\w{3}), (\w{3})/)

class DaysProcessor
    process: (days) ->
        components = days.split(" & ")
        result = []
        (result = result.concat(@_processComponent(c))) for c in components
        return result

    _processComponent: (component) ->
        isRange = rangeRegex.exec component
        if component.search(rangeRegex) > -1
            [_, start, end] = component.match(rangeRegex)
            @_processRange start, end
        else if component.search(commaRegex) > -1
            # We split on commas and then use recursion
            subComponents = []
            (subComponents = subComponents.concat(@_processComponent(c))) for c in component.split(",")
            return subComponents
        else
            [daysArray.indexOf(component.trim())]

    _processRange: (startDay, endDay) ->
        daysOfWeek = []
        # API starts with Monday, so we're fine here
        start = daysArray.indexOf(startDay)

        # Have to handle the end day properly
        if endDay != "Sun"
            end = daysArray.indexOf(endDay)
            daysOfWeek = [start..end]
        else
            end = 6
            daysOfWeek = [start..end]
            daysOfWeek.unshift(0)

        return daysOfWeek

hoursRegex = new RegExp(/(\d{1,2}(:\d{2})? (am|pm))/g)

class TimesProcessor
    process: (hours) ->
        matches = hours.match hoursRegex

        return {
            open: @_processTime matches[0]
            close: @_processTime matches[1]
        }

    _processTime: (timeStr) ->
        [time, ampm] = timeStr.split(" ")
        if time.indexOf(":") != -1
            timeInt = parseInt(time.replace(":", ""))
        else
            timeInt = parseInt(time) * 100

        timeInt += 1200 if ampm == "pm" && timeInt < 1200
        return timeInt

class HoursProcessor
    constructor: ->
        @daysProcessor = new DaysProcessor()
        @timesProcessor = new TimesProcessor()

    processHours: (days, hours) ->
        parsedDays = @daysProcessor.process days
        parsedHours = @timesProcessor.process hours
        obj = {}
        (obj[i] = parsedHours) for i in parsedDays
        return obj

exports.HoursProcessor = HoursProcessor