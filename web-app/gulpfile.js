// This is the gulpfile. It defines all the actions that Gulp (http://gulpjs.com/) will perform
// 
// To start the process, simply navigate to the directory containing this file and run `gulp`. This will run the 'default' task
// 
// The default task will run the LESS compilation and watch all GSP, CSS and JS files for changes to pipe to livereload
// All the gulp processes that we use
var gulp = require("gulp"),
    less = require("gulp-less"),
    livereload = require("gulp-livereload"),
    prefix = require("gulp-autoprefixer"),
    todo = require("gulp-todo"),
    jshint = require("gulp-jshint"),
    notify = require("gulp-notify");

gulp.task("less", function() {
    return gulp.src(["./css/less/*.less"])
    .pipe(less())
    .on("error", notify.onError(function (error) {
        return "Less error: " + error.message;
    }))
    .pipe(prefix("last 2 versions", "Firefox ESR", "> 5%", "ie 10","ie 9"))
    .pipe(gulp.dest("./css"));
});

// run JSHint (http://www.jshint.com/) on all our own JS files (this looks for a .jshintrc file, recursively down the directory tree, so you can put one here or e.g. in the home folder)
gulp.task("lint", function() {
    gulp.src([
        "./js/*.js"
    ])
    .pipe(jshint())
    .pipe(jshint.reporter("jshint-stylish"));
});

// the default gulp task, called if we pass no arguments to `gulp`
gulp.task("default", function () {
    // start our livereload server
    var server = livereload();

    // listen for changes to our .gsp files
    gulp.watch("../grails-app/views/**/*.gsp", function(evt) {
        server.changed(evt.path);
    });

    // watch for changes to our JS files
    gulp.watch("./js/**/*.js", function(evt) {
        server.changed(evt.path);
        gulp.start("lint");
    });

    // watch for changes in the less folder
    gulp.watch("./css/less/*.less", ["less"]);

    gulp.watch("./css/*.css", function(evt) {
        server.changed(evt.path);
    });
});