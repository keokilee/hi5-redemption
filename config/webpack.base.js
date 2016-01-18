module.exports = {
  context: process.cwd(),
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
  output: {
    path: 'public/',
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
    },
    autoprefixer: false,
    postcss: [
      require('postcss-font-magician')(),
      require('postcss-url')(),
      require('postcss-cssnext')(),
      require('postcss-browser-reporter')(),
      require('postcss-reporter')()
    ]
  }
}
