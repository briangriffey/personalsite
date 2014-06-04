define([
  'angular',
  'angular-route',
  'angular-resource',
  './services/index',
  './controllers/index'
  ], function(ng){
    'use strict';

    return ng.module('app', [
      'app.services',
      'app.controllers',
      'ngRoute'
    ]);
});
