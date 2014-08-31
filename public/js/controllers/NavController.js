define([
  './module'
  ], function(controllers) {

    'use strict';
    controllers.controller('NavController', function ($scope){

      $scope.links = [
        {'name':'About', 'link':'#/', 'icon':'glyphicon-user'},
        {'name':"Blog", 'link':'#/blog', 'icon':'glyphicon-book'}
      ];

      $scope.profileImage = "https://pbs.twimg.com/profile_images/447797244121456641/Jz1vTcjH_400x400.jpeg"

    });
  });
