webserver = require 'gulp-webserver'

module.exports = (gulp) ->
  gulp.task 'webserver', ->
    console.log 'webserver!'
    return gulp.src('./build')
      .pipe(webserver({
        host: '0.0.0.0'
        port: 8080
        # livereload: true
        fallback: 'index.html'
      }))
