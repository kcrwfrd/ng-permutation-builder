###
@name widgetFactory
@description
Where widgets get widgetized.
###

angular.module 'app.widget'
.factory 'widgetFactory', (
  permutationFactory
) ->

  build: (attributes) ->
    # Right now you could perform some validation logic,
    # instantiate a model constructor, etc.

    return attributes

  ###
  @name buildPermutations
  @description
  Builds permutations of widgets.

  @param {Object} permutable_attributes
  @param {Object} common_attributes

  @returns {Array.<Widget>} Collection of widgets
  ###

  buildPermutations: (permutable_attributes, common_attributes = {}) ->
    throw Error 'Missing: permutable_attributes' unless permutable_attributes?

    widgets = []

    permutationFactory.permute permutable_attributes, (permutation) =>
      # Extend common attributes onto each permutation
      attributes = _.extend permutation, common_attributes

      widgets.push @build attributes

    return widgets

