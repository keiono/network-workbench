var express = require('express');
const cycx2js = require('cytoscape-cx2js');

var router = express.Router();

router.get('/', function(req, res, next) {
  const param = {
    "name": "cx-api",
    "version": "0.0.1",
  };
  res.header('Content-Type', 'application/json; charset=utf-8')
  res.send(param);
});

router.post('/', (req, res) => {
  const cx = req.body;
  const cyjsObj = fromCx(cx);

  return res.send(cyjsObj);
});



const fromCx = cx => {
  const utils = new cycx2js.CyNetworkUtils();
  const niceCX = utils.rawCXtoNiceCX(cx);
  const cx2Js = new cycx2js.CxToJs(utils);
  const attributeNameMap = {};
  const elements = cx2Js.cyElementsFromNiceCX(niceCX, attributeNameMap);
  const style = cx2Js.cyStyleFromNiceCX(niceCX, attributeNameMap);
  return {
      elements,
      style
  }
}

module.exports = router;
