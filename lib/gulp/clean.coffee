rm = require 'gulp-rimraf'

module.exports = (gulp) ->
  gulp.task 'clean', ->
    return gulp.src 'build/*'
      .pipe(rm())
