fs = require 'fs'
gulp = require 'gulp'
runSequence = require 'run-sequence'

module.exports = do ->
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
      'build:dev'
      [
        'watch'
        'webserver'
      ]
      'karma'
      done
    )

  gulp.task 'build:dev', (done) ->
    runSequence(
      'clean:dev'
      [
        'coffeelint'
        'coffee:dev'
        'sass:dev'
        'vendor:dev'
        'index:dev'
        'templates:dev'
      ]
      done
    )

  gulp.task 'build:dist', (done) ->
    runSequence(
      'clean:dist'
      [
        'coffeelint'
        'coffee:dist'
        'sass:dist'
        'vendor:dist'
        'index:dist'
        'templates:dist'
      ]
      done
    )

  return gulp
