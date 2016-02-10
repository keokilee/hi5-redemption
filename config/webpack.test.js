const path = require('path')
const webpack = require('webpack')

const config = require('./webpack.base')
delete config.entry

config.module.postLoaders = [{
  test: /\.js$/,
  loader: 'isparta',
  include: path.resolve('src')
}]

config.plugins = [
  new webpack.DefinePlugin({
    __DEBUG__: true,
    __MAPS_KEY__: JSON.stringify('testkey')
  })
]

config.vue.loaders.js = 'isparta!babel!eslint'

module.exports = config
