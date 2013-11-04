if (console) console.debug("in adapters/application.js start");
if (console) console.debug("testing: " + Em.testing);

var ApplicationAdapter = null;

if (Em.testing) {
  ApplicationAdapter = DS.FixtureAdapter.extend({});
}
else {
  ApplicationAdapter = DS.RESTAdapter.extend({host: "http://localhost:5901"});
}

if (console) console.debug("in adapters/application.js end");


export default ApplicationAdapter;
