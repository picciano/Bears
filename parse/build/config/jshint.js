/**
 * build.config.jshint
 */
module.exports = function(grunt) {

  var config = grunt.config.get('config');

  // Load task
  grunt.loadNpmTasks('grunt-contrib-jshint');

  // Config
  return {

    all: {
      src: [
        'Gruntfile.js',         // Grunt config files
        'build/config/**/*.js', // Grunt config files
        config.js + '/**/*.js',
        '!'+ config.js + '/**/*min.js',
        '!'+ config.js + '/libs/**/*.js'
      ]
    },

    options: {
      node: true,
      jquery: true,
      browser: true,
      es5: false,
      boss: true,
      curly: true,
      expr: true,
      globalstrict: true,
      immed: false,
      indent: 2,
      strict: false,
      supernew: true,
      white: false
    }

  };
};
