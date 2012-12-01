module.exports = function(grunt) {

  grunt.initConfig({
    watch: { 
      files: ['**/*.coffee', '**/*.html'],
      tasks: 'coffee' 
    },
    coffee: {
      compile: {
        files: {
          'build/sandbox.js': ['sandbox.coffee'],
          'build/test.js': ['test/test.coffee']
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask('default', 'coffee');
};
