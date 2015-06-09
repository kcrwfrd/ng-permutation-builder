###
@name kcPermutableAttribute
@description
Displays the values entered for a permutable attribute.
Allows user to remove a value.

@param {String} name - Permutable attribute key
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

    scope.removeAttribute = (index) ->
      kcPermutationBuilder.removeAttribute scope.name, index
