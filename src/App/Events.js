exports.getN = function() {
    if (!localStorage.n) localStorage.n = 1
    return localStorage.n
};
exports.setN = function() {
    localStorage.n = Math.floor(localStorage.n) + 1
};
