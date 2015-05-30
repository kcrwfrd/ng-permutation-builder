###
@name kcPermutableInput
@description
Encapsulates view logic for permutable inputs, and makes for flexible, reusable
components that we can reuse for any type of permutable resource.

@param {String} name - Permutable attribute key
###

angular.module 'app.permutation'
.directive 'kcPermutableInput', ->
  require: '^kcPermutationBuilder'
  restrict: 'E'
  templateUrl: '/permutation/_permutable-input.html'
  transclude: true

  scope:
    name: '@name'

  link: (scope, element, attrs, kcPermutationBuilder) ->
    # Ensure input IDs are unique
    scope.input_id = _.uniqueId 'permutatable_input_'

    scope.state =
      value: ''
      is_required: attrs.required?

    scope.isDisabled = ->
      return _.isEmpty scope.state.value

    ###
    @name isRequired
    @description
    An input is no longer required if at least 1 value has already been entered

    @returns {Boolean}
    ###

    scope.isRequired = ->
      return attrs.required? and
        kcPermutationBuilder.permutable_attributes[scope.name].length is 0

    scope.submit = ->
      is_added = kcPermutationBuilder.addAttribute(
        scope.name
        scope.state.value
      )

      if is_added
        scope.state.value = ''
