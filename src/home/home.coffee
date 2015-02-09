angular.module 'app.home', [
  'app.widget'
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
