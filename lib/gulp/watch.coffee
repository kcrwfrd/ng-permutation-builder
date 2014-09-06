livereload = require 'gulp-livereload'

scripts = [
  'src/**/*.coffee'
  '!src/**/*.{mock,spec}.coffee'
]

module.exports = (gulp) ->
  gulp.task 'watch', ->
    livereload.listen()

    # Coffeescripts
    gulp.watch [
      'src/**/*.coffee'
      '!src/**/*.{mock,spec}.coffee'
    ], [
      'coffeelint'
      'coffee:dev'
    ]

    # Vendor scripts
    gulp.watch 'lib/gulp/vendor.coffee', [
      'vendor'
    ]

    # Templates
    gulp.watch [
      'src/**/*.jade'
      '!src/index.jade'
    ], [
      'templates'
    ]

    # Index template
    gulp.watch 'src/index.jade', [
      'index'
    ]

    # Gulp files
    gulp.watch [
      'lib/gulp/*.coffee'
      'gulpfile.coffee'
    ], [
      'build'
    ]

    # Livereload
    gulp.watch 'build/**'
    .on 'change', livereload.changed


