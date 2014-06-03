require.config({
  paths: {
    'jquery':'../lib/jquery/dist/jquery',
    'bootstrap':'../lib/bootstrap/dist/js/bootstrap',
    'angular':'../lib/angular/angular',
    'angular-route': '../lib/angular-route/angular-route',
    'domReady':'../lib/requirejs-domready/domReady'
  },

  shim: {
    'bootstrap':{
      deps:['jquery']
    },
    'angular':{
      exports:'angular'
    },
    'angular-route': {
      deps:['angular']
    }
  },

  deps:['./startup']

});
