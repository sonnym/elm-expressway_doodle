var gulp = require("gulp");

require("elm-expressway/gulpfile")(gulp, "Doodle/Client.elm");

gulp.task("default", ["elm-expressway_default"]);
