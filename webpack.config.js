const cssnext = require('postcss-cssnext')
const webpack = require('webpack')

module.exports = {
  devServer: {
    contentBase: `${process.cwd()}/public`,
    host: '0.0.0.0',
    historyApiFallback: true
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
      }, {
        test: /\.css$/,
        loaders: [
          'style',
          'css?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]',
          'postcss'
        ]
      }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      __DEBUG__: true
    })
  ],
  postcss: () => [ cssnext ],
  output: {
    path: `${process.cwd()}/public/assets`,
    publicPath: '/assets',
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
      js: 'babel!eslint'
    }
  }
}
