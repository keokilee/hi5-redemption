const webpack = require('webpack')

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
    __MAPS_KEY__: JSON.stringify('testkey')
  })
]

config.vue.loaders.js = 'isparta'

module.exports = config
