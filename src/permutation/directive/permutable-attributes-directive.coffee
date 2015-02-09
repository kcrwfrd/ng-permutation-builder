###
@name kcPermutableAttributes
@description
A thin controller that manages a `permutable_attributes` data structure, used to
generate permutations of a resource. Exposes an API for consumption by
kcPermutableInput and kcPermutableImage child directives.

@param {Object} permutable_attributes
@param {Callback} buildPermutations

@returns {KcPermutableAttributesController}

@callback buildPermutations
@description
Handler called to generate permutations from the `permutable_attributes` object
when a new attribute is added.

@example
```coffee
$scope.permutable_attributes =
  name: []
  url: []
  thumbnail: []
```

```jade
form(
  name = "widget_form"
  ng-submit = "submit()"
)
  label Permutation Group Name
  input(
    type = "text"
    name = "permutation_group_name"
    ng-model = "state.common_attributes.permutation_group_name"
  )

  kc-permutable-attributes(
    permutable-attributes = "state.permutable_attributes"
    build-permutations = "buildPermutations(permutable_attributes)"
  )
    kc-permutable-input(
      name = "name"
      type = "text"
      required
    ) Name

    kc-permutable-image(
      name = "thumbnail"
      type = "image"
    ) Thumbnail

  button(
    type = "submit"
  ) Submit
```
###

angular.module 'app.permutation'
.directive 'kcPermutableAttributes', ->
  restrict: 'E'
  controller: 'KcPermutableAttributesController'
  scope:
    permutable_attributes: '=permutableAttributes'
    buildPermutations: '&buildPermutations'

.controller 'KcPermutableAttributesController', (
  $scope
) ->
  do setPermutableAttributes = =>
    @permutable_attributes = $scope.permutable_attributes

  # Reset our reference to permutable attributes object when it changes
  $scope.$watch 'permutable_attributes', (new_value, old_value) ->
    setPermutableAttributes() unless new_value is old_value

  ###
  @name addAttribute
  @description
  Adds a permutable attribute

  @returns {Boolean} - Whether attribute was added or not
  ###

  @addAttribute = (key, value) ->
    bucket = $scope.permutable_attributes[key]

    throw Error "Invalid: key '#{key}'" unless bucket?

    if _.contains bucket, value
      console.warn "'#{value}' already entered."

      return false

    # Add the value to permute against
    bucket.push value

    # And generate the permutations
    $scope.buildPermutations
      permutable_attributes: $scope.permutable_attributes

    return true

  return this
