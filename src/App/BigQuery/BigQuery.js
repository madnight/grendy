var axios = require("axios");

exports.bigquery = function(query) {
  return function() {

    return axios("http://localhost:3000").then(function(response){
      var res = [];
      response.data.forEach(function(item) {
      res.push({
                repo: '' + item.name,
                stars: '' + item.todayStars,
               });
      });
      return response.data;
    })
  }
};

