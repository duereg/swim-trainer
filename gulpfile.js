var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');

gulp.task('coffee', function() {
  gulp.src('./public/entrypoint.cjsx', { read: false })
    .pipe(browserify({
      transform: ['coffee-reactify'],
      extensions: ['.cjsx', '.coffee']
    }))
    .pipe(rename('main.js'))
    .pipe(gulp.dest('./public/js'))
});
