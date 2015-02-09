###
@name kcPermutableInput

@param {String} name - Permutable attribute key
###

angular.module 'app.permutation'
.directive 'kcPermutableInput', ->
  require: '^kcPermutableAttributes'
  restrict: 'E'
  templateUrl: '/permutation/_permutable-input.html'
  transclude: true

  scope:
    name: '@name'

  link: (scope, element, attrs, kcPermutableAttributesController) ->
    scope.state =
      value: ''
      is_required: attrs.required?

    scope.submit = ->
      is_added = kcPermutableAttributesController.addAttribute(
        scope.name
        scope.state.value
      )

      if is_added
        scope.state.value = ''
