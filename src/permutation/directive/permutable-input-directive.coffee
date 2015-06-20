###
@name kcPermutableInput
@description
Encapsulates templating and view logic for a permutable input, which is its
own mini form. Makes for a flexible component that can be used to compose the
view for any type of permutable resource.

@param {String} name - Permutable attribute key

@example
```jade
kc-permutable-input(name="title", type="text", required)
```
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

    ###
    @name isDisabled
    @description
    We don't want the submit button to be enabled if input is empty.

    @returns {Boolean}
    ###

    scope.isDisabled = ->
      return _.isEmpty scope.state.value

    ###
    @name isRequired
    @description
    An input is no longer required if at least 1 value has already been entered.

    @returns {Boolean}
    ###

    scope.isRequired = ->
      return attrs.required? and
        kcPermutationBuilder.permutable_attributes[scope.name].length is 0

    ###
    @name submit
    @description
    Adds attribute and clears the input.
    ###

    scope.submit = ->
      is_added = kcPermutationBuilder.addAttribute(
        scope.name
        scope.state.value
      )

      if is_added
        scope.state.value = ''
