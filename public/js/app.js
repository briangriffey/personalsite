define([
  'angular',
  'angular-route',
  './services/index',
  './controllers/index'
  ], function(ng){
    'use strict';

    return ng.module('app', [
      'app.controllers',
      'ngRoute'
    ]);
});
