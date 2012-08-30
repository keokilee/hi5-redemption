# GET home page.
http = require 'http'
settings = require '../settings'

exports.index = (req, res) ->
    res.render 'index', { title: 'Hi5 Redemption' }

exports.api =
    locations: (req, res) ->
        req = http.request settings.config.get('QUERY_URL'), (res) ->
            console.log 'STATUS: ' + res.statusCode
            console.log 'HEADERS: ' + JSON.stringify(res.headers)
            res.setEncoding 'utf8'
            res.on 'data', (chunk) ->
                console.log 'BODY: ' + chunk

        req.write('data\n');
        req.write('data\n');
        req.end();

        res.send {success: true}

    location: (req, res) ->
        res.send {id: req.params.id}
