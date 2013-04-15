# Whitespace trim function for strings.
String::trim = ->
    this.replace /^\s+|\s+$/, ""

DAYS = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]

rangeRegex = new RegExp(/(\w{3}) - (\w{3})/)
commaRegex = new RegExp(/(\w{3}), (\w{3})/)

class HoursProcessor
    processHours: (days, hours) ->
        components = days.split(" & ")
        days = []
        (days = days.concat(@_processComponent(c))) for c in components
        obj = {}
        (obj[i] = "") for i in days
        return obj

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
            [DAYS.indexOf(component.trim())]

    _processRange: (startDay, endDay) ->
        daysOfWeek = []
        # API starts with Monday, so we're fine here
        start = DAYS.indexOf(startDay)

        # Have to handle the end day properly
        if endDay != "Sun"
            end = DAYS.indexOf(endDay)
            daysOfWeek = [start..end]
        else
            end = 6
            daysOfWeek = [start..end]
            daysOfWeek.unshift(0)

        return daysOfWeek

exports.HoursProcessor = HoursProcessor