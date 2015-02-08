jade = require 'gulp-jade'
templateCache = require 'gulp-angular-templatecache'
uglify = require 'gulp-uglify'

module.exports = (gulp) ->
  gulp.task 'templates:dev', ->
    return gulp.src([
        '**/*.jade'
        '!index.jade'
      ], {
        cwd: './src'
      })
      .pipe jade()
      .pipe templateCache 'templates.js',
        standalone: true
        root: '/'
      .pipe gulp.dest 'build/js'

  gulp.task 'templates:dist', ->
    return gulp.src([
        '**/*.jade'
        '!index.jade'
      ], {
        cwd: './src'
      })
      .pipe jade()
      .pipe templateCache 'templates.min.js',
        standalone: true
        root: '/'
      .pipe uglify mangle: false
      .pipe gulp.dest 'dist/js'
