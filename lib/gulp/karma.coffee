karma = require('karma').server

module.exports = (gulp) ->
  gulp.task 'karma', (done) ->
    karma.start
      configFile: __dirname + '/../../karma.conf.coffee'
      autoWatch: true
    , done
