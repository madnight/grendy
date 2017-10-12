exports.now = function() {
    var seconds = new Date().getTime() / 1000;
    return Math.floor(seconds);
};

exports.setTime = function() {
    var seconds = new Date().getTime() / 1000;
    var s =  Math.floor(seconds);
    localStorage.time = s;
};

exports.getTime = function() {
    return Math.floor(localStorage.time);
};

exports.getN = function() {
    if (!localStorage.n)
        localStorage.n = 1
    return localStorage.n
};

exports.setN = function() {
    localStorage.n = Math.floor(localStorage.n) + 1
};





