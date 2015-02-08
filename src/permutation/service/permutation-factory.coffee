angular.module 'app.permutation'
.factory 'permutationFactory', ->

  ###
  @name permute
  @description
  Generates permutations from a permutable_attributes object.

  @param {Object} permutable_attributes
  @param {Callback} callback

  @callback callback
  @param {Object} permutation
  ###

  permute: (permutable_attributes, callback) ->
    # TODO
