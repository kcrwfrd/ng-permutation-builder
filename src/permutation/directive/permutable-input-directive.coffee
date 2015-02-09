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
    # Ensure input IDs are unique
    scope.input_id = _.uniqueId 'permutatable_input_'

    scope.state =
      value: ''
      is_required: attrs.required?

    scope.isDisabled = ->
      return _.isEmpty scope.state.value

    scope.isRequired = ->
      return attrs.required? and
        kcPermutableAttributesController.permutable_attributes[scope.name].length is 0

    scope.submit = ->
      is_added = kcPermutableAttributesController.addAttribute(
        scope.name
        scope.state.value
      )

      if is_added
        scope.state.value = ''
