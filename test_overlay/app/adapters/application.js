var ApplicationAdapter = null;

if (window.testingMode && testingMode() === 'isolated') {
  ApplicationAdapter = DS.PaginationFixtureAdapter.extend({});
}
else {
  ApplicationAdapter = DS.RESTAdapter.extend({host: "http://localhost:5901"});
}

export default ApplicationAdapter;
