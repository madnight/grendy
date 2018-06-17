const gulp = require('gulp')
const ghPages = require('gulp-gh-pages')
const confirm = require('inquirer-confirm')

gulp.task('deploy', (done) => {
    confirm('are you sure you want to deploy to gh-pages').then(() => {
        gulp.src('./static/**/*').pipe(ghPages())
        done()
    }, () => {
        process.stdout.write('deploy aborted\n')
        done()
    })
})
