# Module dependencies.
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
settings = require './settings'

app = express()

app.configure ->
  app.set 'port', settings.get('PORT')
  app.set 'views', (__dirname + '/views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))
  app.use require('connect-assets')()


app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', routes.index
app.get '/locations', routes.api.locations
app.get '/locations/:id', routes.api.location

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
