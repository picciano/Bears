/**
 * build.config.clean
 */
module.exports = function(grunt) {

  var config = grunt.config.get('config');

  // Load task
  grunt.loadNpmTasks('grunt-contrib-clean');

  // Config
  return {

    generated: {
      src: [config.cssmin, config.cssgen, config.css +'/concat', config.jsmin]
    },

    concatcss: {
      src: [config.css +'/concat']
    }

  };
};
