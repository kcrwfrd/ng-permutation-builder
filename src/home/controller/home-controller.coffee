angular.module 'app.home'

.controller 'HomeController', (
  $scope
) ->
  $scope.submit = ($widgets) ->
    console.log 'look at all these widgets we built!'
    console.table _.map $widgets, (widget) -> return widget.attributes

    # Implement your AJAX call here
