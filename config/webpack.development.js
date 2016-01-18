'use strict'

const webpack = require('webpack')
const secrets = require('../secrets.json')
const HtmlWebpackPlugin = require('html-webpack-plugin')

let config = require('./webpack.base')

config.debug = true
config.devServer = {
  contentBase: 'public/',
  host: '0.0.0.0',
  historyApiFallback: true,
  noInfo: true
}

config.devtool = 'eval-source-map'

config.plugins = [
  new webpack.DefinePlugin({
    __DEBUG__: true,
    __MAPS_KEY__: JSON.stringify(secrets.development.GOOGLE_MAPS_API_KEY)
  }),
  new HtmlWebpackPlugin({ title: 'HI-5 Redemption Centers' })
]

module.exports = config
