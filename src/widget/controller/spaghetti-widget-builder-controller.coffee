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

  # This defines the method and immediately invokes it.
  # That way we can reset state if the user hits the reset button.
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

  # Private function called every time an attribute is added or removed
  buildPermutations = ->
    $scope.permutations.length = 0

    # At least we have the `permutationFactory` and `widgetFactory`,
    # which are more obvious as candidates for separate services.
    permutationFactory.permute $scope.permutable_attributes, (permutation) ->
      if widgetFactory.validate permutation
        $scope.permutations.push permutation

  $scope.createPermutations = ->
    widgetStore.addWidgets $scope.permutations

    $state.go 'home'

  $scope.addAttribute = (key) ->
    # Tokenize the value
    $scope.permutable_attributes[key].push $scope.attributes[key]

    # Then empty the form input
    $scope.attributes[key] = ''

    buildPermutations()

  # This view logic would fit much more nicely in a directive.
  $scope.isRequired = (key) ->
    return (
      $scope.required[key] and
      $scope.permutable_attributes[key].length is 0
    )

  # And so would this.
  $scope.isDisabled = (key) ->
    return _.isEmpty $scope.attributes[key]

  $scope.removeAttribute = (key, index) ->
    $scope.permutable_attributes[key].splice index, 1

    buildPermutations()
