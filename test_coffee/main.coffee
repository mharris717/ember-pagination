should = require("should")

setup = require("../lib/module_setup")
testSetup = require("../lib/test_setup")

testSetup.setup()
setup.loadVendorLibs()

auth = require("../lib/main")

App = window.App = Em.Application.create()

App.Store = DS.Store.extend
  revision: 11
  adapter: 'DS.RESTAdapter'


describe "ember pagination", ->
  it "smoke", ->
    num = 2;
    num.should.eql 2

  it 'smoke controller', ->
    a = Em.ArrayController.create()
    res = !!a.modelClass
    res.should.eql true
