`import Widget from 'appkit/models/widget'`

module 'Acceptances - Pagination',
  setup: ->
    App.reset()
    wait()

test 'widget renders', ->
  equal 2,2

widgetTest = (name,f) ->
  test name, ->
    visit("/widgets").then(f)

widgetTest 'list', ->
  equal find(".widget").length,1
  equal find(".widget:eq(0)").text().trim(),"Adam"

widgetTest 'show more', ->
  click(".more-link a").then ->
    equal find(".widget").length,2
    equal find(".widget:eq(1)").text().trim(),"Ben"

widgetTest 'has more link', ->
  equal find(".more-link a").length,1

widgetTest 'has more link goes away', ->
  click(".more-link a").then ->
    equal find(".more-link a").length,0

widgetTest 'metadata look', ->
  click(".more-link a").then ->
    store = App.__container__.lookup("store:main")
    md = store.typeMapFor(Widget).metadata
    equal md.page,2
    equal md.total_pages,2