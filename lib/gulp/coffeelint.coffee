coffeelint = require 'gulp-coffeelint'

module.exports = (gulp) ->
  gulp.task 'coffeelint', ->
    return gulp.src('src/**/*.coffee')
      .pipe(coffeelint())
      .pipe(coffeelint.reporter())
