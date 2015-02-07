concat = require 'gulp-concat'

vendor_scripts = [
  'vendor/bower_components/lodash/dist/lodash.min.js'
  'vendor/bower_components/angular/angular.js'
  'vendor/bower_components/angular-ui-router/release/angular-ui-router.js'
]

module.exports = (gulp) ->
  gulp.task 'vendor', ->
    return gulp.src vendor_scripts
      .pipe concat 'vendor.js'
      .pipe gulp.dest 'build/js'
