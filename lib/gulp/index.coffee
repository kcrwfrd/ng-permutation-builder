jade = require 'gulp-jade'

module.exports = (gulp) ->
  gulp.task 'index:dev', ->
    return gulp.src 'src/index.jade'
      .pipe jade pretty: true
      .pipe gulp.dest 'build'

  gulp.task 'index:dist', ->
    return gulp.src 'src/index.jade'
      .pipe jade()
      .pipe gulp.dest 'dist'
