$(document).bind "mobileinit", ->
    # Disabling jQuery Mobile's nav
    # Courtesy of http://coenraets.org/blog/2012/03/using-backbone-js-with-jquery-mobile/
    $.mobile.ajaxEnabled = false
    $.mobile.linkBindingEnabled = false
    $.mobile.hashListeningEnabled = false
    $.mobile.pushStateEnabled = false