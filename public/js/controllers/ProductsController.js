define(['./module'],
  function(controllers){
    'use strict';
    controllers.controller('ProductsController', function($scope) {
      $scope.products = [
      {"name":"HomeAway", "link":"https://play.google.com/store/apps/details?id=com.vacationrentals.homeaway"},
      {"name":"Evernote", "link":"https://play.google.com/store/apps/details?id=com.evernote"},
      {"name":"Vice", "note":"in collaboration with Thirteen23", "link":"https://play.google.com/store/apps/details?com.vice.viceforandroid"},
      {"name":"Skitch", "link":"https://play.google.com/store/apps/details?id=com.evernote.skitch"},
      {"name":"Simple Desktops", "link":"https://play.google.com/store/apps/details?id=com.simpledesktops"},
      {"name":"Bonfire", "link":"https://play.google.com/store/apps/details?id=com.briangriffey.campfire"},
      {"name":"Talent Scout", "link":"https://play.google.com/store/apps/details?id=com.briangriffey.dribbble"}
      ];
    });
  });
