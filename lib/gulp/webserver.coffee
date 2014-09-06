webserver = require 'gulp-webserver'

module.exports = (gulp) ->
  gulp.task 'webserver', ->
    return gulp.src './build'
      .pipe webserver
        fallback: 'index.html'
        host: 'localhost'
        port: 8080
