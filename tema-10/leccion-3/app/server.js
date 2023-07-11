var restify = require('restify');
var Logger = require('bunyan');


var log = new Logger({
  name: 'helloapi',
  streams: [
    {
      stream: process.stdout,
      level: 'debug'
    },
    {
      path: 'hello.log',
      level: 'trace'
    }
  ],
  serializers: {
    req: Logger.stdSerializers.req,
    res: restify.bunyan.serializers.response,
  },
});


var server = restify.createServer({
  name: 'Hello API',
  log: log
});
server.use(restify.queryParser());

server.pre(function (req, res, next) {
  req.log.info({req: req}, 'start');
  return next();
});

server.get({path: '/hello', name: 'SayHello'}, function(req, res, next) {
  var caller = req.params.name || 'caller';
  req.log.debug('caller is "%s"', caller);
  res.send({"hello": caller});
  return next();
});

server.on('after', function (req, res, route) {
  req.log.info({res: res}, "finished");
});


server.listen(8080, function() {
  log.info('%s listening at <%s>', server.name, server.url);
});