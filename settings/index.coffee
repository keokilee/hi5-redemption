###
Do not edit. Settings are loaded from config directory.
###
settings = require 'nconf'
Connection = require('mongodb').Connection

# First consider commandline arguments and environment variables, respectively.
settings.argv().env()

# Set environment to development if it is not set.
settings.defaults
    'NODE_ENV': 'development'

# Then load the environment's settings.
settings.file { file: 'settings/#{settings.get("NODE_ENV")}.json' }

# Provide default values for settings not provided above.
settings.defaults
    'PORT': 3000
    'SECRET_KEY': ''
    'QUERY_URL': 'http://services.arcgis.com/tNJpAOha4mODLkXz/ArcGIS/rest/services/Refuse_HI5_Redem/FeatureServer/0/query?where=1%3D1&objectIds=&geometry=&geometryType=esriGeometryPoint&inSR=&spatialRel=esriSpatialRelIntersects&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4001&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&f=pjson&token=',
    'MONGO_NODE_DRIVER_HOST': 'localhost',
    'MONGO_NODE_DRIVER_PORT': Connection.DEFAULT_PORT
    'MONGO_NODE_DATABASE': 'hi5-redemption'
    'MONGO_NODE_USERNAME': 'root'
    'MONGO_NODE_PASSWORD': ''

module.exports = settings