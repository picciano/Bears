/**
 * apps/master/app
 */

define('apps/master/app', function(require) {

  'use strict';

  var settings = require('settings'),
      App = {};


  // Mediaqueries
  // NOTE: make sure to sync with scss variables (/source/css/app/_modules/_variables.scss)
  App.mq = {
    small:  '38em', // *16 = 608
    medium: '57em', // *16 = 912
    large:  '82em'  // *16 = 1312
  };


  /**
   * start()
   *
   * Gets the application running
   */
  App.start = function() {
    $('main').append('<p>App Started</p>');
    console.log('App Started');
  };

  return App;

});
