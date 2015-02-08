rm = require 'gulp-rimraf'

module.exports = (gulp) ->
  gulp.task 'clean:dev', ->
    return gulp.src 'build/*', read: false
      .pipe rm()

  gulp.task 'clean:dist', ->
    return gulp.src 'dist/*', read: false
      .pipe rm()
