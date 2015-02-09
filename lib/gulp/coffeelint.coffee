coffeelint = require 'gulp-coffeelint'

module.exports = (gulp) ->
  gulp.task 'coffeelint', ->
    return gulp.src 'src/**/*.coffee'
      .pipe coffeelint
        max_line_length:
          value: 120

      .pipe coffeelint.reporter()
