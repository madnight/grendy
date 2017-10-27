exports.shorten = function(str) {
    if (str) {
        var s = str.replace(/[^\x00-\x7F]/g, "").substring(0, 150);
        return s.length == 150 ? s + "..." : s;
    }
};
exports.toLocaleString  = function(str) { return str.toLocaleString(); };
exports.isEmpty  = function(str) { return str ? str.match(/[\u3400-\u9FBF]/) : true; };
