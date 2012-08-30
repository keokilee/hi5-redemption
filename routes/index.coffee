# GET home page.
locations = require('../locations')

exports.index = (req, res) ->
    res.render 'index'

exports.api =
    locations: (req, res) ->
        locations.get req.params.lat, req.params.long, (result) ->
            res.send result

    location: (req, res) ->
        locations.location parseInt(req.params.id), (result) ->
            res.send result
