var $ = require("jquery");

exports.bigquery = function(query) {
  return function() {
    var f = new Promise(function(resolve) {
    $.post("https://pyapi-vida.herokuapp.com/bigquery", "SELECT events.repo.name AS repo, COUNT(DISTINCT events.actor.id) AS stars FROM ( SELECT * FROM [githubarchive:day.20170920]) AS events WHERE events.type = 'WatchEvent' GROUP BY 1 ORDER BY 2 DESC LIMIT 1000", resolve);
});
    return f.then(function(result) {
      var res = [];
      result.rows.forEach(function(item) {
      res.push({
                repo: '' + item[0],
                stars: '' + item[1],
               });
      });
      console.log(res);
      return res;
    });
  }
};

