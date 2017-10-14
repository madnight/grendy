var axios = require("axios");

exports.fetch = function(url) {
  return function() {
    return axios(url)
      .then(function(response){
        return response.data;
    })
  }
};
