# GET home page.

exports.index = (req, res) ->
  res.render 'index', { title: 'Hi5 Redemption' }
