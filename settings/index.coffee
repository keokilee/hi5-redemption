###
Do not edit. Settings are loaded from config directory.
###
settings = require 'nconf'
Connection = require('mongodb').Connection

# Get settings in order.
env = process.env.NODE_ENV ? 'development'
settings.argv().env().file { file: "settings/#{env}.json" }

# Provide default values for settings not provided above.
settings.defaults
    'PORT': 3000
    'QUERY_URL': 'http://services.arcgis.com/tNJpAOha4mODLkXz/ArcGIS/rest/services/Refuse_HI5_Redem/FeatureServer/0/query?where=1%3D1&objectIds=&geometry=&geometryType=esriGeometryPoint&inSR=&spatialRel=esriSpatialRelIntersects&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4001&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&f=pjson&token=',

module.exports = settings