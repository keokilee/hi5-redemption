settings = require './settings'
# Nodefly monitoring.
if settings.get('NODEFLY_KEY')?
  require('nodefly').profile settings.get('NODEFLY_KEY'), ["hi5-redemption", "hi5-redemption"]

# Module dependencies.
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'

app = express()

app.configure ->
  app.set 'port', settings.get('PORT')
  app.set 'views', (__dirname + '/views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))
  app.use require('connect-assets')()

app.configure 'production', ->
  app.use express.logger('dev')

if app.get('env') != "production"
  app.use express.errorHandler()
  app.use '/mocha/', express.static(path.join(__dirname, 'node_modules', 'mocha'))
  app.use '/chai/', express.static(path.join(__dirname, 'node_modules', 'chai'))
  app.get '/tests', routes.tests

app.get '/', routes.index
app.get '/locations', routes.api.locations
app.get '/locations/:id', routes.api.location

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
