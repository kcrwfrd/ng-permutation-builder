###
@name WidgetBuilderService
@description
Extends PermutationBuilderService for use with widgets.
Drives the business logic of the widget builder UI flow.

NOTE: injection returns an instance, not the constructor (see end of file).
###

angular.module 'app.widget'
.factory 'WidgetBuilderService', (
  PermutationBuilderService
  widgetFactory
  widgetStore
  $q
) ->
  class WidgetBuilderService extends PermutationBuilderService

    ###
    @name initialize
    @description
    Defines permutable attributes for widgets.
    ###

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

    ###
    @name createPermutations
    @description
    Specifies how a permutation gets persisted.

    @returns {Promise} - Fulfilled with the newly created permutations.
    ###

    createPermutations: ->
      # Grab the permutations before we empty them
      permutations = @permutations

      # Implement your AJAX call here
      widgetStore.addWidgets permutations

      # Reset our service
      @initialize()

      return $q.when permutations

  return new WidgetBuilderService()
