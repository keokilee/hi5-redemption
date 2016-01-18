module.exports = (config) => {
  config.set({
    frameworks: [ 'mocha' ],
    reporters: [ 'spec', 'coverage' ],
    files: [
      'test/index.js'
    ],
    preprocessors: {
      'test/index.js': [ 'webpack', 'sourcemap' ]
    },
    browsers: [ 'PhantomJS' ],
    singleRun: true,
    coverageReporter: {
      reporters: [
        { type: 'text' },
        { type: 'html', dir: 'tmp' }
      ]
    },
    webpack: require('./config/webpack.test'),
    webpackMiddleware: {
      noInfo: true
    }
  })
}
