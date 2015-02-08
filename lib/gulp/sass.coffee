sass = require 'gulp-sass'

# So we can @import vendor SCSS files
includePaths = [
  'vendor/bower_components/bootstrap-sass/assets/stylesheets'
]

module.exports = (gulp) ->
  gulp.task 'sass:dev', ->
    return gulp.src 'styles/**/*.scss'
      .pipe sass {includePaths}
      .pipe gulp.dest 'build/css'

  gulp.task 'sass:dist', ->
    return gulp.src 'styles/**/*.scss'
      .pipe sass
        includePaths: includePaths
        outputStyle: 'compressed'

      .pipe gulp.dest 'dist/css'

