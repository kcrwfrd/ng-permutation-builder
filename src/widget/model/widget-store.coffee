###
@name widgetStore
@description
This represents our persisted model layer. In a real application,
it might be responsible for interfacing with an HTTP API or something
like localStorage.
###

angular.module 'app.widget'
.factory 'widgetStore', ->
  widgets = [
    name: 'Foowiz'
    description: 'Descriptive description.'
  ]

  addWidgets: (new_widgets) ->
    widgets = widgets.concat new_widgets

  getWidgets: ->
    return widgets

  deleteWidget: (index) ->
    widgets.splice index, 1
