karma = require('karma').server

module.exports = (gulp) ->
  gulp.task 'karma:dev', (done) ->
    karma.start
      configFile: __dirname + '/../../karma.conf.coffee'
      autoWatch: true
    , done
