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
 
Em.PaginationAdapter = DS.RESTAdapter.extend
  serializer: serializer
 
serializer.configure
  total_pages: 'total_pages'
  page: 'page'