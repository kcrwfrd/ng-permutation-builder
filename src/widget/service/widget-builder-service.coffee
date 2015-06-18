###
@name WidgetBuilderService
@description
Instance of a PermutationBuilderService subclass.
Drives the business logic of the widget builder UI flow.
###

angular.module 'app.widget'
.factory 'WidgetBuilderService', (
  PermutationBuilderService
  widgetFactory
  widgetStore
  $q
) ->
  class WidgetBuilderService extends PermutationBuilderService
    initialize: ->
      super

      @permutable_attributes =
        name: []
        description: []

    ###
    @name buildPermutations
    @description
    Here, we extend the base method to ensure that we only build valid widgets.
    ###

    buildPermutations: ->
      super

      @permutations = _.filter @permutations, widgetFactory.validate

    createPermutations: ->
      # Grab the permutations before we empty them
      permutations = @permutations

      # Implement your AJAX call here
      widgetStore.addWidgets permutations

      # Reset our service
      @initialize()

      return $q.when permutations

  return new WidgetBuilderService()
