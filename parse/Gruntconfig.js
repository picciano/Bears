/**
 * config
 */
module.exports = function() {

  var config = { };

  config.root  = 'public';
  config.js    = config.root + '/js';
  config.jsmin = config.js   + '/min';

  config.css    = config.root + '/css';
  config.cssgen = config.css  + '/generated';
  config.cssmin = config.css  + '/min';

  config.images = config.root + '/images';

  return config;
};
