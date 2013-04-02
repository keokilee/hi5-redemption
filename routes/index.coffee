# GET home page.
LocationService = require('../locations').LocationService
settings = require('../settings')

service = new LocationService(settings.get('MONGO_URL'))

exports.index = (req, res) ->
    res.render 'index', {
        pageTitle: "HI-5 Redemption Centers"
        maps_key: "key=#{settings.get('API_KEY')}"
        fb_app_id: settings.get 'FB_APP_ID'
        analytics_key: settings.get 'ANALYTICS_KEY'
    }

if not process.env.NODE_ENV? or process.env.NODE_ENV is "development"
    exports.tests = (req, res) ->
        res.render 'tests', {
            pageTitle: "Tests"
        }

exports.api =
    locations: (req, res) ->
        if not req.query.lat? or not req.query.long?
            res.send {"error": "Latitude and longitude are required."}
            return

        lat = req.query.lat
        long = req.query.long

        if long < -180.0 or long > 180.0
            res.send {"error": "Invalid longitude value."}
            return

        else if lat < -90.0 or lat > 90.0
            res.send {"error": "Invalid latitude value."}
            return

        service.search lat, long, (result) ->
            res.send result

    location: (req, res) ->
        service.location req.params.id, (result) ->
            if not result?
                res.send "Not found", 404
            else
                res.send result
