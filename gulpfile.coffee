gulp = require 'gulp'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'
istanbul = require 'gulp-coffee-istanbul'
mocha = require 'gulp-mocha'
coffeelint = require 'gulp-coffeelint'
nodemon = require('gulp-nodemon')
jshint = require('gulp-jshint')
stylish = require('jshint-stylish')

jsFiles = ['config/**/*.js', 'controllers/**/*.js', 'models/**/*.js', 'app.js']
specFiles = ['spec/**/*.coffee']
coffeeFiles = ['src/**/*.coffee', 'viewEngines/**/*.coffee']
cjsxFiles = ['public/entrypoint.cjsx', 'views/**/*.cjsx']

gulp.task 'build', ->
  gulp.src('public/entrypoint.cjsx', read: false)
    .pipe(browserify(
      transformAll: true
      transform: ['coffee-reactify']
      extensions: ['.cjsx', '.coffee']
    ))
    .pipe(rename('main.js'))
    .pipe(gulp.dest('./public/js'))

gulp.task 'lint', ->
  gulp.src jsFiles
    .pipe jshint()
    .pipe jshint.reporter(stylish)
    .pipe jshint.reporter('fail')

gulp.task 'develop', ['build'], ->
  nodemon(
    script: 'app.js'
    ext: 'cjsx coffee'
    env: { 'NODE_ENV': 'development' }
    ignore: ['./public/**/*.js'])
    .on 'change', ['build']
    .on 'restart', ->
      console.log('restarted!')

gulp.task 'coffeelint', ->
  gulp.src coffeeFiles.concat(specFiles, 'gulpfile.coffee')
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'watch', ->
  gulp.watch cjsxFiles.concat(jsFiles, specFiles, coffeeFiles), ['build']

gulp.task 'mocha', ->
  gulp.src specFiles
    .pipe mocha reporter: 'spec', compilers: 'coffee:coffee-script'

gulp.task 'test', ['lint', 'coffeelint'], ->
  gulp.src jsFiles.concat(coffeeFiles)
    .pipe istanbul({includeUntested: true}) # Covering files
    .pipe istanbul.hookRequire()
    .on 'finish', ->
      gulp.src specFiles
        .pipe mocha reporter: 'spec', compilers: 'coffee:coffee-script'
        .pipe istanbul.writeReports() # Creating the reports after tests run
        .on 'finish', ->
          process.nextTick ->
            process.exit(0)

gulp.task 'default', ['build']
gulp.task 'heroku:production', ['build']
