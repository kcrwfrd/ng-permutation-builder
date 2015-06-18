###
@name kcPermutableAttribute
@description
Displays the values entered for a permutable attribute.
Allows user to remove a value.

@param {String} name - Permutable attribute key

@example
```jade
kc-permutable-attribute(
  name="description"
) Description
```
###

angular.module 'app.permutation'
.directive 'kcPermutableAttribute', ->
  require: '^kcPermutationBuilder'
  restrict: 'E'
  templateUrl: '/permutation/_permutable-attribute.html'
  transclude: true

  scope:
    name: '@name'

  link: (scope, element, attrs, kcPermutationBuilder) ->
    scope.permutable_attribute =
      kcPermutationBuilder.permutable_attributes[scope.name]

    ###
    @name removeAttribute
    @description
    Calls on service to remove attribute.

    @param {Integer} index - Value's index in the permutable attribute array.
    ###

    scope.removeAttribute = (index) ->
      kcPermutationBuilder.removeAttribute scope.name, index
