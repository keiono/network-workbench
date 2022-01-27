const express = require("express");
const router = express.Router();

router.get("/", function (req, res, next) {
  const param = {
    name: "cx-util-api",
    version: "0.0.1",
    description: "CX to Cytoscape.js util API",
  };
  res.json(param);
});

module.exports = router;
