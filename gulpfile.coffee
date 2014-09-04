fs = require 'fs'

module.exports = (gulp) ->
  fs.readdirSync('lib/gulp').forEach (file) ->
    # Exit if it's not a coffeescript file
    return unless file.match(/.+\.coffee/g) isnt null

    # Load and execute the task definition
    require('./lib/gulp/' + file)(gulp)

  gulp.task 'build', [
    'clean'
    'coffeelint'
    'coffee:dev'
    'vendor'
    'index'
    'templates'
  ]

  gulp.task 'default', [
    'build'
    'webserver'
  ]
