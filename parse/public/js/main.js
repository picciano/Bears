/**
 * main and config
 *
 * Require configuration and definition of main
 */
require.config({

  // Increase the wait time before giving up on a script
  waitSeconds: 15,

  baseUrl: 'js',

  paths: {
    // Core Libraries
    jquery:    'libs/jquery-1.11.1.min',
    underscore:'libs/lodash.underscore.min',

    // Helper Modules
    helpers: 'apps/helpers'

    // 3rd party
  },

  // Sets the configuration for your third party scripts that are not AMD compatible
  shim: {

    underscore: {
      exports: '_'
    },

    lodash: {
      exports: '_'
    }

  }
}); // end require.config


/**
 * main
 */
define('main', function() {

  'use strict';

  require(['apps/master/app'], function(App) { 

    // Start the application
    App.start();

  });
});
