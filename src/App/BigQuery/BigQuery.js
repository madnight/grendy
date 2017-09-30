var axios = require("axios");

exports.bigquery = function(query) {
  return function() {
    return axios("https://grendy.herokuapp.com")
      .then(function(response){
        return response.data;
    })
  }
};

