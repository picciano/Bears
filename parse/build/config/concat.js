/**
 * build.config.concat
 */
module.exports = function(grunt) {

  var config = grunt.config.get('config');

  // Load task
  grunt.loadNpmTasks('grunt-contrib-concat');

  // Config
  return {

    css: {
      src: [config.cssgen +'/**/*.css'],
      dest: config.css +'/concat/app.css'
    }

  };
};
