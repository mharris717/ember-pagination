module 'Acceptances - Pagination'

test 'widget renders', ->
  equal 2,2

test 'list', ->
  visit("/widgets").then ->
    equal find(".widget").length,1
    equal find(".widget:eq(0)").text().trim(),"Adam"

test 'show more', ->
  visit("/widgets")
  .click(".more-link a").then ->
    equal find(".widget").length,2
    equal find(".widget:eq(1)").text().trim(),"Ben"