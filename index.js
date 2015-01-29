var path = require("path");

var server = require("elm-expressway/lib/server");
var socket = require("elm-expressway/lib/socket");

var basePath = path.resolve(process.cwd());
var filename = path.resolve(basePath, "Doodle", "Server.elm");

var doodleSocketConfig = {
  filename: filename,
  basePath: basePath,
  portDefaults: {
    receiveInput: 0
  },

  onConnection: onConnection
};

var doodleSocket = socket(doodleSocketConfig);

doodleSocket(server);

server.listen(8000, "0.0.0.0");

function onConnection(doodleServer) {
  return function(connection) {
    doodleServer.emitter.on("sendState", function(state) {
      connection.write(state);
    });

    connection.on("data", function(input) {
      doodleServer.emitter.emit("receiveInput", JSON.parse(input));
    });

    connection.on("close", function() { });
  };
}
