###
@name permutationFactory
@description
Utility service for generating permutations of a resource.
###

angular.module 'app.permutation'
.factory 'permutationFactory', ->

  ###
  @name permute
  @description
  Generates permutations from a permutable_attributes object.

  @param {Object} permutable_attributes
  @param {[Callback]} callback - Optional, invoked for each permutation

  @callback callback
  @param {Object} permutation

  @returns {Array} - Collection of permutations

  @example
  ```coffeescript
  permutations = permutationFactory.permute
    name: ['Foobar', 'Bizbat']
    description: ['I pity the foo.', 'Lorem ipsum.']
  ```
  ###

  permute: (permutable_attributes, callback) ->
    permutations = []

    recurse = (keys, payload = {}, position = 0) ->
      # We've finished constructing the permutation, exit call stack
      if position is keys.length
        permutation = _.clone payload
        callback? permutation
        permutations.push permutation

        return

      # Grab the current key
      key = keys[position]

      # There are no values for this attribute, skip it
      if permutable_attributes[key].length is 0
        recurse keys, payload, position + 1

      # Otherwise, recurse for each possible value of this attribute
      else
        for value in permutable_attributes[key]
          payload[key] = value

          recurse keys, payload, position + 1

    recurse Object.keys permutable_attributes

    return permutations
