define(['./app'], function(app){
  'use strict';
  return app.config(['$routeProvider', function($routeProvider){
    $routeProvider.when('/', {
        templateUrl: 'partials/products.html',
        controller: 'ProductsController'
    });

    $routeProvider.when('/products', {
      templateUrl: 'partials/products.html',
      controller: 'ProductsController'
    });

    $routeProvider.when('/blog', {
      templateUrl: 'partials/blogs.html',
      controller: 'BlogPostController'
    });

  }]);
});
