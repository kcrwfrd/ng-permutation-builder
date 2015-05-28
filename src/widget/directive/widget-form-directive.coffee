###
@name kcWidgetForm
@description
Form used to build permutations of widgets.

@param {Callback} onSubmit

@callback onSubmit
@description
Callback handler that decides what to do with the payload

@param {Array} widgets - Collection of built widgets
###

angular.module 'app.widget'

.directive 'kcWidgetForm', ->
  restrict: 'E'
  controller: 'KcWidgetFormController'
  templateUrl: '/widget/_widget-form.html'

  scope:
    onSubmit: '&onSubmit'

.controller 'KcWidgetFormController', (
  $scope
  widgetFactory
) ->
  $scope.state =
    common_attributes:
      permutation_group_name: ''

    permutable_attributes:
      name: []
      description: []

  # Collection of built widget permutations
  $scope.widgets = []

  $scope.buildPermutations = (permutable_attributes) ->
    $scope.widgets =
      widgetFactory.buildPermutations(
        permutable_attributes
        $scope.state.common_attributes
      )

  $scope.submit = ->
    $scope.onSubmit
      $widgets: $scope.widgets
