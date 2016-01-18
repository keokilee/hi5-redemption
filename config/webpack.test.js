const webpack = require('webpack')
const vue = require('vue-loader')
const secrets = require('../secrets.json')

module.exports = {
  context: process.cwd(),
  debug: true,
  devtool: 'inline-source-map',
  entry: {},
  eslint: {
    formatter: require('eslint-friendly-formatter')
  },
  module: {
    preLoaders: [{
      test: /\.js$/,
      loader: 'isparta',
      exclude: /node_modules/
    }, {
      test: /\.vue$/,
      loader: vue.withLoaders({
        js: 'isparta'
      })
    }],
    loaders: [
      {
        test: /\.vue$/,
        loader: 'vue'
      }, {
        test: /\.js$/,
        loaders: [ 'babel', 'eslint' ],
        exclude: /node_modules/
      }, {
        test: /\.json$/,
        loader: 'json'
      }, {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: '[name].[ext]?[hash]'
        }
      }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      __DEBUG__: true,
      __MAPS_KEY__: JSON.stringify(secrets.development.GOOGLE_MAPS_API_KEY)
    })
  ],
  output: {
    path: `${process.cwd()}/public/assets`,
    publicPath: '/',
    filename: '[name].js'
  },
  resolve: {
    extensions: ['', '.js', '.vue'],
    alias: {
      'src': `${process.cwd()}/src`
    }
  },
  vue: {
    loaders: {
      js: 'babel!eslint',
      postcss: [
        require('postcss-font-magician')(),
        require('postcss-url')(),
        require('postcss-cssnext')(),
        require('postcss-browser-reporter')(),
        require('postcss-reporter')()
      ],
      autoprefixer: false
    }
  }
}
