define(['./module'],
  function(controllers){
    controllers.controller('BlogController',["$scope", "$sce", '$routeParams', "Blog", function($scope, $sce, $routeParams, Blog){

        $scope.blogResource = Blog.get({'blog': $routeParams.blogId}, function(blog) {
          $scope.blog = blog;
        });

        $scope.to_trusted = function(html_code) {
            return $sce.trustAsHtml(html_code);
        }
    }]);

  });
