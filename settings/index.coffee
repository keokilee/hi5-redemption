###
Do not edit. Settings are loaded from settings directory.
###
settings = require 'nconf'

# Get settings in order.
env = process.env.NODE_ENV ? 'development'
settings.argv().env().file { file: "settings/#{env}.json" }

# Provide default values for settings not provided above.
settings.defaults
    'PORT': 3000
    'QUERY_URL': 'http://services.arcgis.com/tNJpAOha4mODLkXz/arcgis/rest/services/RefuseHI5/FeatureServer/0/query?where=1%3D1&objectIds=&geometry=&geometryType=esriGeometryPoint&inSR=&spatialRel=esriSpatialRelIntersects&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4001&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&f=pjson&token='
    "MONGO_URL": "mongodb://localhost:27017/hi5"

module.exports = settings