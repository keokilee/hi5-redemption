const webpack = require('webpack')
const secrets = require('../secrets.json')

const config = require('./webpack.base')
delete config.entry

config.module.preLoaders = [{
  test: /\.js$/,
  loader: 'isparta!eslint',
  include: 'src/'
}]

config.plugins = [
  new webpack.DefinePlugin({
    __DEBUG__: true,
    __MAPS_KEY__: JSON.stringify(secrets.development.GOOGLE_MAPS_API_KEY)
  })
]

config.vue.loaders.js = 'isparta'

module.exports = config
