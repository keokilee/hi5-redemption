const webpack = require('webpack')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const secrets = require('./secrets.json')

module.exports = {
  devServer: {
    contentBase: `${process.cwd()}/dist`,
    host: '0.0.0.0',
    historyApiFallback: true,
    noInfo: true
  },
  devtool: 'eval-source-map',
  entry: {
    app: './src/main.js'
  },
  eslint: {
    formatter: require('eslint-friendly-formatter')
  },
  module: {
    loaders: [
      {
        test: /\.vue$/,
        loader: 'vue'
      }, {
        test: /\.js$/,
        loader: 'babel!eslint',
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
    new HtmlWebpackPlugin({
      title: 'HI5 Redemption Centers'
    }),
    new webpack.DefinePlugin({
      __DEBUG__: true,
      __MAPS_KEY__: JSON.stringify(secrets.development.GOOGLE_MAPS_API_KEY)
    })
  ],
  output: {
    path: `${process.cwd()}/dist`,
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
