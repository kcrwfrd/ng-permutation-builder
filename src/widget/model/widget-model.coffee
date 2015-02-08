angular.module 'app.widget'
.factory 'Widget', ->
  class Widget
    constructor: (@attributes) ->
      console.log 'new widget created', @attributes
