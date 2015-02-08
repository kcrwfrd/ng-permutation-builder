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
    permutations = []

    recurse = (keys, payload = {}, position = 0) ->
      key = keys[position]

      # There are no values for this attribute, skip it
      if permutable_attributes[key].length is 0
        if position < keys.length - 1
          recurse keys, payload, position + 1
        else
          permutations.push _.clone payload

      for value in permutable_attributes[key]
        payload[key] = value

        if position is keys.length - 1
          permutations.push _.clone payload

        else
          recurse keys, payload, position + 1

    recurse Object.keys permutable_attributes

    return permutations
