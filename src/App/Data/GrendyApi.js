var axios = require("axios");
var $ = require("jquery");

exports.fetch = function(url) {
  return function() {
    return axios(url)
      .then(function(response){
        console.log("REEELOAD")
        return response.data;
    })
  }
};

exports.isBottom = function(url) {
  return ($(window).scrollTop()
    + $(window).height() + 2000)
    > $(document).height();
};
