exports.trends = function(language) {
  return function() {
    var Trending = require("github-trend");
    var scraper = new Trending.Scraper();
    return scraper.scrapeTrendingRepos(language)
      .then(function(repos){
        return repos;
      }).catch(function(err){
        return err.message
      });
  }
};
