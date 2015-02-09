angular.module 'app.home'

.controller 'HomeController', (
  $scope
  widgetStore
) ->
  $scope.widgets = widgetStore.getWidgets()

  $scope.deleteWidget = (index) ->
    widgetStore.deleteWidget index
