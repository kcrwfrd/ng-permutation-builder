###
@name WidgetBuilderController
@description
Our controller becomes a very thin layer that binds what we need to the view,
and handles a minimal amount of logic.
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
