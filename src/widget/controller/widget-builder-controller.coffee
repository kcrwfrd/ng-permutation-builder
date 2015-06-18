angular.module 'app.widget'
.controller 'WidgetBuilderController', (
  $scope
  $state
  WidgetBuilderService
) ->
  $scope.WidgetBuilderService = WidgetBuilderService

  $scope.submit = ->
    WidgetBuilderService.createPermutations().then (widgets) ->
      console.log 'look at all these widgets we built!'
      console.table widgets

      $state.go 'home'
