jade = require 'gulp-jade'
templateCache = require 'gulp-angular-templatecache'

module.exports = (gulp) ->
  gulp.task 'templates', ->
    return gulp.src([
        '**/*.jade'
        '!index.jade'
      ], {
        cwd: './src'
      })
      .pipe jade()
      .pipe templateCache
        standalone: true
        root: '/'
      .pipe gulp.dest 'build/js'
