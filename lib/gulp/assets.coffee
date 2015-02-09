module.exports = (gulp) ->
  gulp.task 'assets:dev', ->
    return gulp.src 'vendor/bower_components/bootstrap-sass/assets/fonts/**/*'
      .pipe gulp.dest 'build/fonts'

  gulp.task 'assets:dist', ->
    return gulp.src 'vendor/bower_components/bootstrap-sass/assets/fonts/**/*'
      .pipe gulp.dest 'dist/fonts'
