$(document).ready ->
    $("#about-popup").popup()

    $("#about").click ->
        $("#about-popup").popup "open", {
            transition: 'pop'
            positionTo: 'window'
        }
