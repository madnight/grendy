var axios = require("axios");

exports.bigquery = function(query) {
  return function() {
    return axios.post("https://pyapi-vida.herokuapp.com/bigquery", "SELECT events.repo.name AS repo, COUNT(DISTINCT events.actor.id) AS stars FROM ( SELECT * FROM [githubarchive:day.20170920]) AS events WHERE events.type = 'WatchEvent' GROUP BY 1 ORDER BY 2 DESC LIMIT 1000").then(function(response) {
    console.log(response)
      var res = [];
      response.data.rows.forEach(function(item) {
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

