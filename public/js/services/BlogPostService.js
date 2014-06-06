define(['./module'],
  function(services) {
    services.factory('Blog', ['$resource', function($resource){
      return $resource('blogs/:blog.json', {blog: '1'});
    }]);
  }
);
