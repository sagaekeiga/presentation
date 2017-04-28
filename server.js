var express = require('express');
var app = express();

var server = require('http').createServer(app);
var io = require('socket.io').listen(server);

server.listen(3001);
console.log('Server listening on port 3001');


app.use(function(req, res, next){
  console.log("error")
  console.log('%s %s', req.method, req.url);
  next();
});

io.sockets.on('connection', function (socket) {
  socket.on('disconnect', function () {
    console.log("user disconnected");
  });

});