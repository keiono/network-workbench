var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  const param = {
    "name": "cx-api",
    "version": "0.0.1",
  };
  res.header('Content-Type', 'application/json; charset=utf-8')
  res.send(param);
});

module.exports = router;
