'use strict';

var gulp = require('gulp'),
  sass = require('gulp-sass'),
  csso = require('gulp-csso'),
  autoprefixer = require('gulp-autoprefixer'),
  browserify = require('browserify'),
  watchify = require('watchify'),
  source = require('vinyl-source-stream'),
  buffer = require('vinyl-buffer'),
  babelify = require('babelify'),
  uglify = require('gulp-uglify'),
  del = require('del'),
  notify = require('gulp-notify'),
  sourcemaps = require('gulp-sourcemaps'),
  envify = require('envify'),
  livereload = require('gulp-livereload'),
  runsequence = require('run-sequence'),
  p = {
    jsx: 'scripts/index.js',
    scss: 'styles/jesque.scss',
    faFont: 'node_modules/font-awesome/fonts/**',
    bundle: 'jesque.js',
    distJs: './../web-app/js',
    distCss: './../web-app/css',
    fontDest: './../web-app/fonts',
    imgDest: './../web-app/images',
    imgSrc: 'images/**',
    babelOptions: {
      presets: ['es2015', 'react']
    }
  };

gulp.task('clean', function(cb) {
  return del(['dist', 'deploy'], cb);
});

gulp.task('watchify', function() {
  var args = watchify.args;
  args.transform = ['envify'];
  var bundler = watchify(
    browserify(p.jsx, args)
    .transform(babelify)
  )

  function rebundle() {
    return bundler
      .bundle()
      .on('error', notify.onError())
      .pipe(source(p.bundle))
      .pipe(gulp.dest(p.distJs))
      .pipe(livereload());
  }

  bundler.transform(babelify)
    .on('update', rebundle);
  return rebundle();
});

gulp.task('browserify', function() {
  console.log("browserify")
  return browserify(p.jsx, {
      transform: ['envify']
    })
    .transform(babelify)
    .bundle()
    .pipe(source(p.bundle))
    .pipe(buffer())
    .pipe(sourcemaps.init({
      loadMaps: true
    }))
    .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest(p.distJs));
});

gulp.task('styles', function() {
  return gulp.src(p.scss)
    .pipe(sass().on('error', notify.onError()))
    .pipe(autoprefixer('last 1 version'))
    .pipe(csso())
    .pipe(gulp.dest(p.distCss))
    .pipe(livereload());
});

gulp.task('fonts', function() {
  return gulp.src(p.faFont)
    .pipe(gulp.dest(p.fontDest))
});

gulp.task('images', function() {
  return gulp.src(p.imgSrc)
    .pipe(gulp.dest(p.imgDest))
});

gulp.task('watchImages', function() {
  return gulp.watch(p.imgSrc, ['images'])
})

gulp.task('watchTask', function() {
  gulp.watch("styles/**/*.scss", ['styles']);
});

gulp.task('watch', ['clean'], function() {
  livereload.listen();
  gulp.start(['watchTask', 'watchify', 'styles', 'fonts', 'watchImages']);
});

gulp.task('default', function() {
  return gulp.start("watch")
});

gulp.task('bundle', function() {
  process.env.NODE_ENV = 'production';
  return runsequence('clean', ['browserify', 'styles', 'fonts', 'images'], 'prepare-assets');
});
