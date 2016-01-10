const HtmlWebpackPlugin = require('html-webpack-plugin')
const cssnext = require('postcss-cssnext')

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
      }, {
        test: /\.css$/,
        loaders: [
          'style',
          'css?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]',
          'postcss-loader'
        ]
      }
    ]
  },
  plugins: [ new HtmlWebpackPlugin({ title: 'HI-5 Redemption Centers' }) ],
  postcss: () => [ cssnext ],
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
      js: 'babel!eslint'
    }
  }
}
