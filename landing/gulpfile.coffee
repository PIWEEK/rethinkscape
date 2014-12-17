gulp = require('gulp')

# Utilities
plumber = require("gulp-plumber")
size = require("gulp-filesize")
watch = require("gulp-watch")
cache = require("gulp-cached")
concat = require("gulp-concat")

# HTML
jade = require("gulp-jade")
htmlhint = require("gulp-htmlhint")
# CSS
sass = require('gulp-sass')
#sass = require("gulp-ruby-sass")
# Linter
csslint = require("gulp-csslint")
scsslint = require("gulp-scss-lint")
#coffee
coffee = require('gulp-coffee')
coffeelint = require('gulp-coffeelint')
# Optimization
imagemin = require('gulp-imagemin')
pngquant = require('imagemin-pngquant')
# Connect
webserver = require('gulp-webserver')

##############################################################################
# Ordered list of paths
##############################################################################
paths = {
    app: "app",
    dist: "dist",
    #################
    jade: "app/**/*.jade",
    html: "dist/views/**/*.html",
    #################
    scss: "app/**/*.scss",
    scssMain: "app/styles/main.scss",
    vendor: "bower_components/**/*.scss",
    cssDistFold: "dist/styles/",
    cssMainDist: "dist/styles/main.css",
    #################
    coffee: "app/scripts/**/*.coffee" #This will probably will become a ordered list of files because of JS order dependency
    #################
    imageMain: "app/images/*"
    imageDist: "dist/images/"
    ##################
    svgMain: "app/svg/*"
    svgDist: "dist/svg/"
    ##################
    fontsMain: "app/fonts/*"
    fontsDist: "dist/fonts/"
}

##############################################################################
# HTML Related tasks
##############################################################################

gulp.task "jade", ->
    gulp.src(paths.jade)
        .pipe(plumber())
        .pipe(cache("jade"))
        .pipe(jade({pretty: true}))
        .pipe(size())
        .pipe(gulp.dest(paths.dist))

gulp.task "htmlhint", ->
    gulp.src(paths.html)
        .pipe(htmlhint())

##############################################################################
# CSS Related tasks
##############################################################################

gulp.task "scsslint", ->
    gulp.src([paths.scss])
        .pipe(cache("scsslint"))
        .pipe(scsslint(
            {'config': 'scsslint.yml'}
        ))

gulp.task "sass", ["scsslint"], ->
    gulp.src([paths.scssMain])
        .pipe(plumber())
        .pipe(sass())
        .pipe(size())
        .pipe(gulp.dest(paths.cssDistFold))

gulp.task "csslint", ->
    gulp.src(paths.cssMainDist)
        .pipe(plumber())
        .pipe(cache("csslint"))
        .pipe(csslint("csslintrc.json"))

##############################################################################
# Script related tasks
##############################################################################

gulp.task 'coffeelint', ->
    gulp.src(paths.coffee)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())

gulp.task "coffee", ->
    gulp.src(paths.coffee)
        .pipe(plumber())
        .pipe(coffee())
        .pipe(concat("scripts.js"))
        .pipe(gulp.dest(paths.dist + "/scripts"))


##############################################################################
# Image related tasks
##############################################################################

gulp.task 'imagemin', ->
    return gulp.src(paths.imageMain)
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()]
        }))
        .pipe(gulp.dest(paths.imageDist));

##############################################################################
# Common related tasks
##############################################################################

#Copy Fonts
gulp.task "copy",  ->
    gulp.src(paths.fontsMain)
        .pipe(gulp.dest(paths.fontsDist))
    gulp.src(paths.svgMain)
        .pipe(gulp.dest(paths.svgDist))

##############################################################################
# Server Related tasks
##############################################################################

# Rerun the task when a file changes
gulp.task "watch", ->
    gulp.watch(paths.jade, ["jade"])
    gulp.watch(paths.scss, ["scsslint", "sass", "csslint"])
    gulp.watch(paths.coffee, ["coffeelint", "coffee"])

gulp.task 'webserver', ->
    gulp.src(paths.dist)
        .pipe(webserver({
            livereload: true,
            port: 8080
        }))

##############################################################################
# manage Tasks
##############################################################################

gulp.task "default", [
    "jade",
    "htmlhint"
    "scsslint",
    "sass",
    "csslint",
    "coffeelint",
    "coffee",
    "imagemin",
    "copy",
    "webserver",
    "watch"
]
