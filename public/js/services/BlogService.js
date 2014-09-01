define(['./module'],
  function(services) {
    services.factory('Blogs', ['$resource', function($resource){
      return $resource('blogs.json', {});
    }]);
  }
);
