var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');

gulp.task('build', function() {
  gulp.src('./public/entrypoint.cjsx', { read: false })
    .pipe(browserify({
      transform: ['coffee-reactify'],
      extensions: ['.cjsx', '.coffee']
    }))
    .pipe(rename('main.js'))
    .pipe(gulp.dest('./public/js'))
});

gulp.task('watch', function() {
  gulp.watch(['public/entrypoint.cjsx', 'views/**/*.cjsx', 'src/**/*.coffee'], ['build']);
});

gulp.task('default', ['build']);
gulp.task('heroku:production', ['build']);
