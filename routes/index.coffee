# GET home page.
LocationService = require('../locations').LocationService
settings = require('../settings')

service = new LocationService(settings.get('MONGO_URL'))

exports.index = (req, res) ->
    res.render 'index', {
        maps_key: "key=#{settings.get('API_KEY')}"
        fb_app_id: settings.get 'FB_APP_ID'
        analytics_key: settings.get 'ANALYTICS_KEY'
    }

exports.api =
    locations: (req, res) ->
        service.search req.query.lat, req.query.long, (result) ->
            res.send result

    location: (req, res) ->
        service.location req.params.id, (result) ->
            res.send result
