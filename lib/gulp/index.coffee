jade = require 'gulp-jade'

module.exports = (gulp) ->
  gulp.task 'index:dev', ->
    return gulp.src 'src/index.jade'
      .pipe jade
        pretty: true
        locals:
          title: 'Development'
          scripts: [
            '/js/vendor.js'
            '/js/templates.js'
            '/js/app.js'
          ]

      .pipe gulp.dest 'build'

  gulp.task 'index:dist', ->
    return gulp.src 'src/index.jade'
      .pipe jade
        pretty: true
        locals:
          title: 'Production'
          scripts: [
            './js/vendor.min.js'
            './js/templates.min.js'
            './js/app.min.js'
          ]

      .pipe gulp.dest 'dist'
