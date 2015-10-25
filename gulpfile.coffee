'uset strict'
gulp = require 'gulp'
watch = require 'gulp-watch'
uglify = require 'gulp-uglify'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
rename = require 'gulp-rename'
compass = require 'gulp-compass'
minifycss = require 'gulp-minify-css'
browserSync = require 'browser-sync'
cp = require 'child_process'

js_dest = "javascript"
css_dest = "stylesheets"
css_source_dir = "_assets/stylesheets"
js_source = "_assets/javascript/**/*.js"
coffee_source = "_assets/javascript/**/*.coffee"
scss_source = "_assets/stylesheets/**/*.scss"

gulp.task('jekyll-build',(done) ->
  browserSync.notify('<span style="color: grey">Running:</span> $ jekyll build')
  return cp.spawn('bundle',['exec','jekyll','build'],{stdio: 'inherit'})
    .on('close',done)
)

gulp.task('jekyll-rebuild',['jekyll-build'],->
  browserSync.reload()
)

gulp.task('browser-sync',['jekyll-build','uncompressed'],->
  browserSync(
    server:
      baseDir: '_site'
    ui: false
    open: false
    port: 4000
    host: '0.0.0.0'
  )
)

gulp.task 'compressed', ->
  gulp.src(coffee_source)
    .pipe(coffee({bare: true}).on('error',gutil.log))
    .pipe(uglify())
    #.pipe(rename({extname: '.min.js'}))
    .pipe(gulp.dest(js_dest))
  gulp.src(js_source)
    .pipe(uglify())
    #.pipe(rename({extname: '.min.js'}))
    .pipe(gulp.dest(js_dest))
  gulp.src(scss_source)
    .pipe(compass({
      css: css_dest
      sass: css_source_dir
    }))
    .pipe(minifycss())
    #.pipe(rename({extname: '.min.css'}))
    .pipe(gulp.dest(css_dest))

gulp.task 'uncompressed', ->
  gulp.src(coffee_source)
    #.pipe(coffee({bare: true}).on('error',gutil.log))
    .pipe(coffee({bare: true}).on('error', (err)->
      console.log "#{err.name}:\"#{err.message}\" in #{err.filename}:#{err.location.first_line}"
    ))
    .pipe(gulp.dest(js_dest))
  gulp.src(js_source)
    .pipe(gulp.dest(js_dest))
  gulp.src(scss_source)
    .pipe(compass({
      css: css_dest
      sass: css_source_dir
    }))

gulp.task 'watch',->
  watch(coffee_source).on 'change', (path)->
    js_dest = path.split("/").slice(0,-1).join("/").replace("_assets/","")
    dest = path.split("/").slice(0,-1).join("/").replace("_assets/","_site/")
    gulp.src(path)
    .pipe(coffee({bare: true}).on('error', (err)->
      console.log "#{err.name}:\"#{err.message}\" in #{err.filename}:#{err.location.first_line}"
    ))
    .pipe(gulp.dest(dest))
    .pipe(gulp.dest(js_dest))
    .pipe(browserSync.reload({stream:true}))
    console.log path + ' was changed'
  watch(js_source).on 'change', (path)->
    js_dest = path.split("/").slice(0,-1).join("/").replace("_assets/","")
    dest = path.split("/").slice(0,-1).join("/").replace("_assets/","_site/")
    gulp.src(path)
    .pipe(gulp.dest(dest))
    .pipe(gulp.dest(js_dest))
    .pipe(browserSync.reload({stream:true}))
    console.log path + ' was changed'
  watch(scss_source).on 'change',(path) ->
    dest = "_site/" + css_dest
    gulp.src(path)
      .pipe(compass({
        css: dest
        sass: css_source_dir
      }))
      .on('error',(err)->
        console.log err.message
        this.emit('end')
      )
      .pipe(gulp.dest(css_dest))
      .pipe(browserSync.reload({stream:true}))
      console.log path + ' was changed'
  gulp.watch(['*.html', '*.md','_jk_gallery/*.html', '_gallery_list/*.html','_cameraman_galery/*.html','_party_gallery/*.html','_includes/*.html', '_layouts/*.html', '_posts/*'], ['jekyll-rebuild'])

gulp.task 'dev',['browser-sync','watch']

gulp.task 'default', ['compressed']

