'use strict'

mountFolder = (connect, dir) ->
  connect.static require('path').resolve(dir)

module.exports = (grunt) ->
  require('time-grunt') grunt
  require('load-grunt-tasks') grunt

  yeomanConfig =
    app: 'app'
    dist: 'dist'

  serverConfigs =
    port: 9002
    protocol: 'http'


  grunt.initConfig
    yeoman: yeomanConfig

    watch:
      options:
        nospawn: true
      coffee:
        files: [ '<%= yeoman.app %>/scripts/**/{,*/}*.coffee' ]
        tasks: [ 'coffee:dist' ]
      css:
        files: [
          '<%= yeoman.app %>/styles/{,*/}*.{scss, css}'
          '<%= yeoman.app %>/styles/{,*/*/}*.{scss, css}'
        ]
        tasks: [ 'sass' ]
      build:
        files: [ '<%= yeoman.app %>/**/{,*/}*.{html}' ]
        tasks: [ 'build' ]
      coffeeTest:
        files: [ 'test/{,*/}*.coffee' ]
        tasks: [ 'coffee:test' ]
      jst:
        files: [ '<%= yeoman.app %>/scripts/**/*.ejs' ]
        tasks: [ 'jst' ]
    sass:
      dist:
        files: '.tmp/styles/application.css': 'app/styles/application.scss'

    connect:
      options: serverConfigs

      server:
        options: serverConfigs

      livereload:
        options:
          middleware: (connect) ->
            [
              mountFolder(connect, '.tmp')
              mountFolder(connect, yeomanConfig.app)
            ]
      test:
        options:
          middleware: (connect) ->
            [
              mountFolder(connect, '.tmp')
              mountFolder(connect, 'test')
              mountFolder(connect, yeomanConfig.app)
            ]
      dist:
        options:
          middleware: (connect) ->
            [mountFolder(connect, yeomanConfig.dist)]

    open:
      server:
        path: '<%= connect.options.protocol %>://localhost:<%= connect.options.port %>'
    clean:
      dist: [
        '.tmp'
        '<%= yeoman.dist %>/*'
      ]
      server: '.tmp'
    coffee:
      dist:
        files: [ {
          expand: true
          cwd: '<%= yeoman.app %>/scripts'
          src: '**/**/*.coffee'
          dest: '.tmp/scripts'
          ext: '.js'
        } ]

      localConfig:
        files:
          '.tmp/scripts/environment.js': '<%= yeoman.app %>/config/environment/local.coffee'
          '.tmp/scripts/endpoints.js': '<%= yeoman.app %>/config/endpoints/local.coffee'

      sandboxConfig:
        files:
          '.tmp/scripts/environment.js': '<%= yeoman.app %>/config/environment/sandbox.coffee'
          '.tmp/scripts/endpoints.js': '<%= yeoman.app %>/config/endpoints/sandbox.coffee'

      qaConfig:
        files:
          '.tmp/scripts/environment.js': '<%= yeoman.app %>/config/environment/qa.coffee'
          '.tmp/scripts/endpoints.js': '<%= yeoman.app %>/config/endpoints/qa.coffee'

      prodConfig:
        files:
          '.tmp/scripts/environment.js': '<%= yeoman.app %>/config/environment/prod.coffee'
          '.tmp/scripts/endpoints.js': '<%= yeoman.app %>/config/endpoints/prod.coffee'

      test:
        files: [ {
          expand: true
          cwd: 'test'
          src: '**/**/*.coffee'
          dest: '.tmp/spec'
          ext: '.js'
        } ]
    useminPrepare:
      html: '<%= yeoman.app %>/index.html'
      options:
        dest: '<%= yeoman.dist %>'
    usemin:
      html: [ '<%= yeoman.dist %>/{,*/}*.html' ]
      css: [ '<%= yeoman.dist %>/styles/{,*/}*.css' ]
      options: dirs: [ '<%= yeoman.dist %>' ]
    cssmin:
      dist:
        files:
          '<%= yeoman.dist %>/styles/application.css': [
            '.tmp/styles/{,*/}*.css'
            '<%= yeoman.app %>/styles/{,*/}*.css'
          ]
    copy:
      dist:
        files: [ {
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>'
          src: [
            '*.{ico,txt,html}'
            '.htaccess'
            'images/{,*/}*.{webp,gif,svg}'
          ]
        } ]
    jst:
      compile:
        files: '.tmp/scripts/templates.js': [ '<%= yeoman.app %>/scripts/**/*.ejs' ]
    processhtml:
      dist:
        files: '<%= yeoman.dist %>/index.html': [ '<%= yeoman.dist %>/index.html' ]
    rev:
      dist:
        files:
          src: [
            '<%= yeoman.dist %>/scripts/{,*/}*.js'
            '<%= yeoman.dist %>/styles/*.css'
            '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}'
            '<%= yeoman.dist %>/styles/fonts/*'
          ]

  grunt.registerTask 'createDefaultTemplate', ->
    grunt.file.write '.tmp/scripts/templates.js', 'this.JST = this.JST || {};'
    return

  grunt.registerTask 'server', (target) ->
    if target == 'dist'
      return grunt.task.run([
        'buildLocal'
        'open'
        'connect:dist:keepalive'
      ])
    else if target == 'test'
      return grunt.task.run([
        'clean:server'
        'coffee'
        'createDefaultTemplate'
        'jst'
        'connect:test:keepalive'
      ])
    grunt.task.run [
      'clean:server'
      'buildLocal'
      'sass'
      'coffee:dist'
      'createDefaultTemplate'
      'jst'
      'connect:livereload'
      'open'
      'watch'
    ]
    return

  grunt.registerTask 'buildDev', [
    'clean:dist'
    'coffee:sandboxConfig'
    'build'
  ]

  grunt.registerTask 'devServer', [
    'buildDev'
    'connect:livereload'
    'open'
    'watch'
  ]

  grunt.registerTask 'test', [
    'clean:server'
    'coffee:dist'
    'coffee:test'
    'coffee:localConfig'
    'createDefaultTemplate'
    'jst'
    'sass'
  ]

  grunt.registerTask 'beforeTestem', [
    'coffee:test'
  ]

  grunt.registerTask 'buildLocal', [
    'clean:dist'
    'coffee:localConfig'
    'build'
  ]

  grunt.registerTask 'localServer', [
    'buildLocal'
    'connect:livereload'
    'open'
    'watch'
  ]
  grunt.registerTask 'buildSandbox', [
    'clean:dist'
    'coffee:sandboxConfig'
    'build'
  ]

  grunt.registerTask 'buildQA', [
    'clean:dist'
    'coffee:qaConfig'
    'build'
  ]

  grunt.registerTask 'buildProd', [
    'clean:dist'
    'coffee:prodConfig'
    'build'
  ]

  grunt.registerTask 'build', [
    'coffee:dist'
    'copy'
    'sass'
    'createDefaultTemplate'
    'jst'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'rev'
    'usemin'
    'processhtml'
  ]

  grunt.registerTask 'default', [ 'devServer' ]
  return
