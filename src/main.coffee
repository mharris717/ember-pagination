DS.Model.reopenClass
  storeMetadata: (store,k) ->
    res = store.typeMapFor(@).metadata
    res = res[k] if k
    res

  setStoreMetadata: (store,k,v) ->
    res = store.typeMapFor(@).metadata
    res[k] = v

  loadMore: (store) ->
    page = @storeMetadata(store,'page') + 1
    @setStoreMetadata(store,'page',page)
    store.findQuery('widget',page: page)
    page

  hasMore: (store) ->
    page = @storeMetadata(store,'page')
    total = @storeMetadata(store,'total_pages')
    unfiltered = @storeMetadata(store,'unfiltered_total_pages')
    page < unfiltered
 
Em.ArrayController.reopen
  modelClass: ->
    res = null
    @forEach (obj) ->
      res ||= obj.constructor 
    res

  showMore: ->
    page = @modelClass().loadMore(@get('store'))
    @set 'lastKnownPage',page

  hasMore: (->
    if @modelClass()
      @modelClass().hasMore(@get('store'))
    else
      false).property('lastKnownPage','firstObject','@each','filtered.@each')

DS.PaginationFixtureAdapter = DS.FixtureAdapter.extend
  findAll: (store,type) ->
    type.setStoreMetadata(store,"page",1)

    all = @fixturesForType(type)
    res = all.slice(0,1)

    res
      
  queryFixtures: (fixtures, query, type) ->
    page = query.page || 1
    type.setStoreMetadata(@get('store'),"page",page) if @get('store')
    start = (page-1)*1

    fixtures.slice(start,start+1)


if false
  serializer = DS.RESTSerializer.create()
   
  Em.PaginationAdapter = DS.RESTAdapter.extend
    serializer: serializer

  if serializer.configure
    serializer.configure
      total_pages: 'total_pages'
      page: 'page'
      unfiltered_total_pages: 'unfiltered_total_pages'