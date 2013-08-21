require "./module_setup"

auth = {}

DS.Model.reopenClass
  loadMore: ->
    page = DS.defaultStore.typeMapFor(@).metadata.page + 1
    @find(page: page)
 
Em.ArrayController.reopen
  modelClass: ->
    @get('firstObject').constructor
  showMore: ->
    @modelClass().loadMore()
 
serializer = DS.RESTSerializer.create()
 
Em.PaginationAdapter = DS.RESTAdapter.reopen
  serializer: serializer
 
serializer.configure
  total: 'total'
  last_dt: 'last_dt'
  total_pages: 'total_pages'
  page: 'page'

module.exports = auth