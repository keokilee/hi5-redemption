'use strict'

const webpack = require('webpack')
const ExtractTextWebpackPlugin = require('extract-text-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const AppcacheWebpackPlugin = require('appcache-webpack-plugin')

const secrets = require('../secrets.json')
let config = require('./webpack.base')

config.debug = false
config.devtool = 'source-map'
config.output = {
  path: 'dist/',
  filename: '[name].[hash].js'
}

config.plugins = [
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: 'production'
    },
    __DEBUG__: false,
    __MAPS_KEY__: JSON.stringify(secrets.production.GOOGLE_MAPS_API_KEY)
  }),
  new webpack.optimize.DedupePlugin(),
  new webpack.optimize.UglifyJsPlugin({
    minimize: true,
    sourceMap: true,
    compress: { warnings: false }
  }),
  new webpack.optimize.OccurenceOrderPlugin(),
  new ExtractTextWebpackPlugin('[name].[contenthash].css'),
  new AppcacheWebpackPlugin(),
  new HtmlWebpackPlugin({
    title: 'HI-5 Redemption Centers',
    template: 'template.html',
    inject: true,
    minify: {
      removeComments: true,
      collapseWhitespace: true
    }
  })
]

config.vue.loaders = {
  js: 'babel!eslint',
  css: ExtractTextWebpackPlugin.extract('vue-style', 'css?sourceMap')
}

module.exports = config
