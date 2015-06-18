###
@name PermutationBuilderService
@description
A base class that can be extended for use with different permutable resources.
###

angular.module 'app.permutation'
.factory 'PermutationBuilderService', (
  permutationFactory
) ->
  class PermutationBuilderService
    constructor: ->
      @initialize()

    ###
    @name initialize
    @description
    Method used to reset service to an empty state.
    Override this method to define attributes for a permutable resource.
    ###

    initialize: ->
      # Regular attributes that get added to each permutation
      @attributes = {}

      # Permutable attributes
      @permutable_attributes = {}

      # Collection of permutations
      @permutations = []

    ###
    @name addAttribute
    @description
    Adds a permutable attribute

    @param {String} key - Name of attribute
    @param {String|Number|Object|Array} value - Can be of any type

    @returns {Boolean} Whether attribute was added successfully or not.
    ###

    addAttribute: (key, value) ->
      bucket = @permutable_attributes[key]

      throw Error "Invalid key: '#{key}'" unless bucket?

      if _.contains bucket, value
        console.warn "'#{value}' already entered."

        return false

      # Add the value to permute against
      bucket.push value

      # And generate the permutations
      @buildPermutations()

      return true

    ###
    @name buildPermutations
    @description
    Builds permutations of the resource.

    @returns {Array} Collection of permutations
    ###

    buildPermutations: ->
      # Empty our collection of permutations from previous runs
      @permutations.length = 0

      permutationFactory.permute @permutable_attributes, (permutation) =>
        # Extend common attributes onto each permutation
        resource = _.extend permutation, @attributes

        @permutations.push resource

      return @permutations

    ###
    @name createPermutations
    @description
    Abstract method. Override to define how a permutable resource gets persisted.
    ###

    createPermutations: ->

    ###
    @name removeAttribute
    @description
    Removes a permutable attribute by index

    @param {String} key - Attribute name
    @param {Integer} index - Index of value in the permutable attribute array.

    @returns {Boolean} - true if item successfully removed
    ###

    removeAttribute: (key, index) ->
      bucket = @permutable_attributes[key]

      throw Error "Invalid key: '#{key}'" unless bucket?

      removed = bucket.splice index, 1

      @buildPermutations()

      return removed.length > 0
