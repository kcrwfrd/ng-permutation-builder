angular.module 'app.home', [
  'ui.router'
]

.config (
  $stateProvider
) ->
  $stateProvider.state 'home',
    url: '/home'
    views:
      'main':
        controller: 'HomeController'
        templateUrl: '/home/home.html'
