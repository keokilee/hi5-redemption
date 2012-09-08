# GET home page.
location_service = require('../location_service')
settings = require('../settings')

service = new location_service.LocationService()

exports.index = (req, res) ->
    res.render 'index', {key: settings.get('API_KEY')}

exports.api =
    locations: (req, res) ->
        service.search req.query.lat, req.query.long, (result) ->
            res.send result

    location: (req, res) ->
        service.location req.params.id, (result) ->
            res.send result
