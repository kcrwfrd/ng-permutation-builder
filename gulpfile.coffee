fs = require 'fs'

module.exports = (gulp) ->
  # Let's load all of our gulp tasks
  fs.readdirSync('lib/gulp').forEach (file) ->

    # Exit if it's not a coffeescript file
    return unless file.match(/.+\.coffee/g) isnt null

    # Load and execute the task definition
    require('./lib/gulp/' + file)(gulp)

  gulp.task 'default', [
    'build'
    'karma:dev'
    'watch'
    'webserver'
  ]

  # Ensure that clean finishes first
  gulp.task 'build', [
    'clean'
  ], ->
    gulp.start(
      'coffeelint'
      'coffee:dev'
      'vendor'
      'index'
      'templates'
    )
