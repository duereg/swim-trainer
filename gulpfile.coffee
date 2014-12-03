gulp = require 'gulp'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'
istanbul = require 'gulp-istanbul'
mocha = require 'gulp-mocha'
coffeelint = require 'gulp-coffeelint'

gulp.task 'build', ->
  gulp.src('public/entrypoint.cjsx', read: false)
    .pipe(browserify(
      transform: ['coffee-reactify']
      extensions: ['.cjsx', '.coffee']
    ))
    .pipe(rename('main.js'))
    .pipe gulp.dest('./public/js')

gulp.task 'lint', ->
  gulp.src ['src/**/*.coffee', 'spec/**/*.coffee', 'gulpfile.coffee']
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'watch', ->
  gulp.watch [
    'public/entrypoint.cjsx'
    'views/**/*.cjsx'
    'src/**/*.coffee'
  ], ['build']

gulp.task 'test', ->
  gulp.src ['controllers/**/*.js', 'models/**/*.js', 'app.js']
    .pipe istanbul({includeUntested: true}) # Covering files
    .pipe istanbul.hookRequire()
    .on 'finish', ->
      gulp.src ['spec/**/*.spec.coffee']
        .pipe mocha reporter: 'spec', compilers: 'coffee:coffee-script'
        .pipe istanbul.writeReports() # Creating the reports after tests run
        .on 'finish', ->
          process.nextTick ->
            process.exit(0)


gulp.task 'default', ['build']
gulp.task 'heroku:production', ['build']
