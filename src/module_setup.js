res = {}

res.loadVendorLibs = function() {
  _ = require('./vendor/underscore');
  Handlebars = require("handlebars");
  require('./vendor/ember');
  require('./vendor/ember_data');
}

module.exports = res