concat = require 'gulp-concat'

# Non-minified files for easier debugging
vendor_dev = [
  'vendor/bower_components/lodash/lodash.js'
  'vendor/bower_components/angular/angular.js'
  'vendor/bower_components/angular-ui-router/release/angular-ui-router.js'
]

# Minified for optimization
vendor_dist = [
  'vendor/bower_components/lodash/lodash.min.js'
  'vendor/bower_components/angular/angular.min.js'
  'vendor/bower_components/angular-ui-router/release/angular-ui-router.min.js'
]

module.exports = (gulp) ->
  gulp.task 'vendor:dev', ->
    return gulp.src vendor_dev
      .pipe concat 'vendor.js'
      .pipe gulp.dest 'build/js'

  gulp.task 'vendor:dist', ->
    return gulp.src vendor_dist
      .pipe concat 'vendor.min.js'
      .pipe gulp.dest 'dist/js'
