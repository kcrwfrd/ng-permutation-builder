###
@name kcPermutationBuilder
@description
This serves as a way to bind an instance of a PermutationBuilderService and
expose its API to a group of `kcPermutableInput` directives.

@param {PermutationBuilderService} service - Or a subclass thereof
###

angular.module 'app.permutation'
.directive 'kcPermutationBuilder', ->
  restrict: 'E'
  controller: 'KcPermutationBuilderController'
  scope:
    service: '='

.controller 'KcPermutationBuilderController', (
  $scope
) ->
  @permutable_attributes = $scope.service.permutable_attributes

  @addAttribute =
    angular.bind $scope.service, $scope.service.addAttribute

  @removeAttribute =
    angular.bind $scope.service, $scope.service.removeAttribute
