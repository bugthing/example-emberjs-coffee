module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    watch:
      files: ['dist/index.html', 'dist/js/*.js']
      options:
        livereload: true
      templates:
        files: ['templates/*.handlebars']
        tasks: ['emberTemplates']
      index:
        files: ['templates/index.html', 'templates/tests.html']
        tasks: ['processhtml']
      js:
        files: ['js/**/*.coffee']
        tasks: ['coffeelint', 'coffee']
      tests:
        files: ['dist/test.html']
        tasks: ['qunit']

    connect:
      server:
        options:
          port: 9001
          base: 'dist/'

    processhtml:
      options:
        data:
          scripts:  """
            <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.js"></script>
            <script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.js"></script>
            <script src="//cdnjs.cloudflare.com/ajax/libs/ember.js/1.7.0/ember.js"></script>
            <script src="js/ember-templates.js"></script>
            """
      dist:
        files:
          'dist/index.html': ['templates/index.html']
          'dist/tests.html': ['templates/tests.html']

    emberTemplates:
      compile:
        options:
          templateName: (sourceFile) ->
            return sourceFile.replace /templates\//, ''
        files:
          "dist/js/ember-templates.js": "templates/*.handlebars"

    coffee:
      compileJoined:
        options:
          join: true
        files:
          'dist/js/application.js': ['js/*.coffee']
          'dist/js/tests.js': ['js/*.coffee', 'js/tests/*.coffee']

    coffeelint:
      app: ['js/*.coffee']
      tests: ['js/test/*.coffee']

    qunit:
      all:
        options:
          urls: [ 'http://localhost:9001/tests.html' ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-ember-templates'
  grunt.loadNpmTasks 'grunt-processhtml'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-qunit';

  grunt.registerTask 'default', ['coffeelint','coffee', 'emberTemplates', 'processhtml', 'connect', 'watch']
