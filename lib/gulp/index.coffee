jade = require 'gulp-jade'

module.exports = (gulp) ->
  gulp.task 'index', ->
    return gulp.src 'src/index.jade'
      .pipe jade(pretty: true)
      .pipe gulp.dest('build')
