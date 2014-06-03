define(['./app'], function(app){
  'use strict';
  return app.config(['$routeProvider', function($routeProvider){
    $routeProvider.when('/', {
        templateUrl: 'partials/main.html',
        controller: 'MainController'
    });

    $routeProvider.when('/nav', {
      templateUrl: 'partials/nav.html',
      controller: 'NavController'
    });
  }]);
});
