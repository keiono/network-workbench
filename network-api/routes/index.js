var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  const param = {
    "name": "graph-util-api",
    "version": "0.0.1",
  };
  res.header('Content-Type', 'application/json; charset=utf-8')
  res.send(param);
});

module.exports = router;
