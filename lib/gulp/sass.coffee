sass = require 'gulp-sass'

# So we can @import vendor SCSS files
includePaths = [
  'vendor/bower_components/bootstrap-sass/assets/stylesheets'
]

module.exports = (gulp) ->
  gulp.task 'sass:dev', ->
    return gulp.src 'styles/**/*.scss'
      .pipe sass
        includePaths: includePaths
        # Minimum precision of 8 decimal points required for bootstrap.
        # See https://github.com/twbs/bootstrap-sass#sass-number-precision
        precision: 8

      .pipe gulp.dest 'build/css'

  gulp.task 'sass:dist', ->
    return gulp.src 'styles/**/*.scss'
      .pipe sass
        includePaths: includePaths
        outputStyle: 'compressed'
        precision: 8

      .pipe gulp.dest 'dist/css'

