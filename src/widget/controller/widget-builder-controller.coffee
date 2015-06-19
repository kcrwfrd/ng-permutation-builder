###
@name WidgetBuilderController
@description
Our controller and its template become a very thin layer that
glue the pieces together.
###

angular.module 'app.widget'
.controller 'WidgetBuilderController', (
  $scope
  $state
  WidgetBuilderService
) ->
  $scope.WidgetBuilderService = WidgetBuilderService

  ###
  @name submit
  @description
  Calls on the service to create permutations, then redirects to home page.
  ###

  $scope.submit = ->
    WidgetBuilderService.createPermutations().then (widgets) ->
      console.log 'look at all these widgets we built!'
      console.table widgets

      $state.go 'home'
