###
@name SpaghettiWidgetBuilderController
@description
While seeming rather innocuous at first, this controller will continue
to get more bloated as we add new features, like

* Supporting permutable images
* Supporting permutable videos
* Granular error and validation messaging

It also does a poor job of separating concerns:

* Drives the whole UI, rather than leveraging separate, tightly-focused components
* Mixes up business logic and state with view logic and state

Worst of all, it's completely unreusable! What happens when we want to create
a permutation builder for Gadgets?
###

angular.module 'app.widget'
.controller 'SpaghettiWidgetBuilderController', (
  $scope
  $state
  permutationFactory
  widgetFactory
  widgetStore
) ->
  # Placeholder object to hold references for our ngForm instances
  $scope.forms = {}

  ###
  @name initialize
  @description
  Resets state, called if the user hits the reset button.

  The `do` immediately invokes our method to initialize state when
  controller first loads.
  ###

  do $scope.initialize = ->
    $scope.permutations = []

    $scope.permutable_attributes =
      name: []
      description: []

    # For binding to the form with ngModel
    $scope.attributes =
      name: ''
      description: ''

  # We need to specify which fields are required. We can't just use a
  # 'required' attribute on the input tag, because it will no longer
  # be required once at least 1 value has been entered.
  $scope.required =
    name: true
    description: false

  ###
  @name buildPermutations
  @description
  Private function called every time an attribute is added or removed.
  ###

  buildPermutations = ->
    $scope.permutations.length = 0

    # At least we have the `permutationFactory` and `widgetFactory`,
    # which are more obvious as candidates for separate services.
    permutationFactory.permute $scope.permutable_attributes, (permutation) ->
      if widgetFactory.validate permutation
        $scope.permutations.push permutation

  ###
  @name createPermutations
  @description
  Persists the permutations and redirects to home page.
  ###

  $scope.createPermutations = ->
    widgetStore.addWidgets $scope.permutations

    $state.go 'home'

  ###
  @name addAttribute
  @description
  Adds an attribute to generate permutations from, then empties the form input.

  @param {String} key - Attribute name
  ###

  $scope.addAttribute = (key) ->
    # Tokenize the value
    $scope.permutable_attributes[key].push $scope.attributes[key]

    # Then empty the form input
    $scope.attributes[key] = ''

    buildPermutations()

  ###
  @name isRequired
  @description
  Used with ng-required, determines if at least 1 value has been entered or not.
  This view logic would fit much more nicely in a directive.

  @param {String} key - Attribute name

  @returns {Boolean}
  ###

  $scope.isRequired = (key) ->
    return (
      $scope.required[key] and
      $scope.permutable_attributes[key].length is 0
    )

  ###
  @name isDisabled
  @description
  We don't want the submit button to be enabled if input is empty.
  Also a good candidate for inclusion in a directive.

  @param {String} key - Attribute name

  @returns {Boolean}
  ###

  $scope.isDisabled = (key) ->
    return _.isEmpty $scope.attributes[key]

  ###
  @name removeAttribute
  @description
  Removes a permutable attribute, then re-generates permutations.

  @param {String} key - Attribute name
  @param {Integer} index - Index in the permutable attribute array.
  ###

  $scope.removeAttribute = (key, index) ->
    $scope.permutable_attributes[key].splice index, 1

    buildPermutations()
