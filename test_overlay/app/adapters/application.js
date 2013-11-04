console.debug("in adapters/application.js start");

var ApplicationAdapter = null;

if (Em.testing) {
  ApplicationAdapter = DS.FixtureAdapter.extend({});
}
else {
  ApplicationAdapter = DS.RESTAdapter.extend({host: "http://localhost:5901"});
}

console.debug("in adapters/application.js end");


export default ApplicationAdapter;
