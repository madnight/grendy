const gulp = require('gulp')
const ghPages = require('gulp-gh-pages')
const confirm = require('inquirer-confirm')

gulp.task('deploy', () => {
    confirm('are you sure you want to deploy to gh-pages').then(() => {
        return gulp.src('./static/**/*')
        .pipe(ghPages())
    }, () => {
        process.stdout.write('deploy aborted\n')
    })
})

