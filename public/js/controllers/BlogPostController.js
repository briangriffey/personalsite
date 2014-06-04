define(['./module'],
  function(controllers){
    controllers.controller('BlogPostController',["$scope", "$sce", "Blog", function($scope, $sce, Blog){
        $scope.blogs = Blog.query();

        $scope.to_trusted = function(html_code) {
            return $sce.trustAsHtml(html_code);
        }
    }]);

  });
