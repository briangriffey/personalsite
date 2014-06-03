define([
  './module'
  ], function(controllers) {
    'use strict';

    controllers.controller('NavController', function ($scope){
      
      $scope.links = [
        {'name':"Blog", 'link':'#/nav'}
      ];

      $scope.profileImage = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/t1.0-1/c36.0.320.320/p320x320/1972346_10102166624279538_1986754100_n.jpg"


    });
  });
