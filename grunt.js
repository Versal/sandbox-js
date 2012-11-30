module.exports = function(grunt) {

  grunt.initConfig({
    watch: { tasks: 'coffee' },
    coffee: {
      compile: {
        files: {
          'build/sandbox.js': ['sandbox.coffee']
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask('default', 'coffee');
};
