###
@name WidgetBuilderService
@description
Instance of a PermutationBuilderService subclass.
Drives the business logic of the widget builder UI flow.
###

angular.module 'app.widget'
.factory 'WidgetBuilderService', (
  PermutationBuilderService
  widgetStore
  $q
) ->
  class WidgetBuilderService extends PermutationBuilderService
    initialize: ->
      super

      @permutable_attributes =
        name: []
        description: []

    createPermutations: ->
      # Grab the permutations before we empty them
      permutations = @permutations

      # Implement your AJAX call here
      widgetStore.addWidgets permutations

      # Reset our service
      @initialize()

      return $q.when permutations

  return new WidgetBuilderService
