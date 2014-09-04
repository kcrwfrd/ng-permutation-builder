angular.module 'app', [
  'templates'
  'app.home'
  'ui.router'
]

.config (
  $stateProvider
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/home'
