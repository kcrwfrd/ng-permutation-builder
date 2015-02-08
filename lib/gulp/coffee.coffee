coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
util = require 'gulp-util'

scripts = [
  'src/**/*.coffee'
  '!src/**/*.{mock,spec}.coffee'
]

module.exports = (gulp) ->
  gulp.task 'coffee:dev', ->
    return gulp.src scripts
      .pipe(coffee()).on 'error', util.log
      .pipe concat 'app.js'
      .pipe gulp.dest 'build/js'

  gulp.task 'coffee:dist', ->
    return gulp.src scripts
      .pipe(coffee()).on 'error', util.log
      .pipe concat 'app.min.js'

      # `mangle: false` So we don't bork dependency injection.
      # TODO: use https://github.com/olov/ng-annotate
      .pipe uglify mangle: false

      .pipe gulp.dest 'dist/js'
