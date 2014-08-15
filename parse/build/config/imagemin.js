/**
 * build.config.imagemin
 */
module.exports = function(grunt) {

  var config = grunt.config.get('config');

  // Load task
  grunt.loadNpmTasks('grunt-contrib-imagemin');

  // Config
  return {

    images: {
      expand: true,
      cwd: config.images,
      src: ['**/*.{png,jpg,gif}'],
      dest: config.images
    }

  };
};
