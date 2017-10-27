exports.shorten = function(str) {
    if (str) {
        var s = str.replace(/[^\x00-\x7F]/g, "").substring(0, 150);
        if (s.length == 150)
            return s + "...";
        else
            return s;
    }
};
exports.toLocaleString  = function(str) { return str.toLocaleString(); };
exports.isEmpty  = function(str) { return str ? false : true; };
