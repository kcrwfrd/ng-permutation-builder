angular.module 'app', [
  'app.home'
  'templates'
  'ui.router'
]

.config (
  $stateProvider
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/home'
