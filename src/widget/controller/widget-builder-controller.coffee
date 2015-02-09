angular.module 'app.widget'

.controller 'WidgetBuilderController', (
  $scope
  $state
  widgetStore
) ->
  $scope.submit = ($widgets) ->
    console.log 'look at all these widgets we built!'
    console.table $widgets

    # Implement your AJAX call here
    widgetStore.addWidgets $widgets

    $state.go 'home'
