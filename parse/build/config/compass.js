/**
 * build.config.compass
 */
module.exports = function(grunt) {

  var config = grunt.config.get('config');

  // Load task
  grunt.loadNpmTasks('grunt-contrib-compass');

  // Config
  return {

    all: {
      options: {
        relativeAssets: true,
        sassDir: config.css +'/app',
        cssDir: config.cssgen
      }
    }

  };
};
