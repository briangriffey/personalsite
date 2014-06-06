define(['./module'],
  function(controllers){
    controllers.controller('BlogsController',["$scope", "$sce", "Blogs", function($scope, $sce, Blogs){
        $scope.blogs = Blogs.query();

        $scope.to_trusted = function(html_code) {
            return $sce.trustAsHtml(html_code);
        }
    }]);

  });
