jade = require 'gulp-jade'
template_cache = require 'gulp-angular-templatecache'

module.exports = (gulp) ->
  gulp.task 'templates', ->
    return gulp.src([
        '**/*.jade'
        '!index.jade'
      ], {
        cwd: './src'
      })
      .pipe jade()
      .pipe template_cache standalone: true
      .pipe gulp.dest 'build/js'
