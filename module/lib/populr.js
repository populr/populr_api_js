var fermata = require('fermata');

fermata.registerPlugin('populr', function (transport, host, key) {
    this.base = "http://" + key + ":x@" + host;

    return function (request, callback) {
        // we can make usage much cleaner by automatically appending this extension
        request.path[request.path.length-1] += ".json";
        return transport.using('autoConvert', "application/json")(request, function (err, response) {
            callback(err, response);
        });
    };
});


module.exports = {
    config: function(key, host) {
        if (host == null)
            host = 'api.populr.me'
        return fermata.populr(host, key);
    }
}