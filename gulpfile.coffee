fs = require 'fs'
runSequence = require 'run-sequence'

module.exports = (gulp) ->
  # Let's load all of our gulp tasks
  fs.readdirSync('lib/gulp').forEach (file) ->

    # Exit if it's not a coffeescript file
    return unless file.match(/.+\.coffee/g)?

    # Load and execute the task definition
    require('./lib/gulp/' + file)(gulp)

  # Note: runSequence will be obviated by Gulp 4
  # See https://github.com/gulpjs/gulp/issues/355

  gulp.task 'default', (done) ->
    runSequence(
      'build'
      [
        'watch'
        'webserver'
      ]
      'karma'
      done
    )

  gulp.task 'build', (done) ->
    runSequence(
      'clean'
      [
        'coffeelint'
        'coffee:dev'
        'vendor'
        'index'
        'templates'
      ]
      done
    )
