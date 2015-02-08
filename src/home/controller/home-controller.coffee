angular.module 'app.home'

.controller 'HomeController', (
  $scope
) ->
  console.log 'we hood now'

  $scope.submit = ($widgets) ->
    console.log 'look at all these widgets we built!'
    console.table $widgets

    # Implement your AJAX call here
