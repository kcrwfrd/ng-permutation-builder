module.exports = (config) ->
  config.set
    basePath: ''

    frameworks: [
      'jasmine'
    ]

    files: [
      'build/js/vendor.js'
      'build/js/app.js'
      'vendor/angular-mocks/angular-mocks.js'
      'src/**/*.{mock,spec}.coffee'
    ]

    preprocessors:
      'src/**/*.{mock,spec}.coffee': [
        'coffee'
      ]

    reporters: [
      'progress'
    ]

    colors: true

    browsers: [
      'PhantomJS'
    ]
