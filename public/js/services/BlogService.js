define(['./module'],
  function(services) {
    services.factory('Blog', ['$resource', function($resource){
      return $resource('blogs', {}, {
        query: {method: 'GET', isArray:true}
      });
    }]);
  }
);
