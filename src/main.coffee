DS.Model.reopenClass
  storeMetadata: (k) ->
    res = DS.defaultStore.typeMapFor(@).metadata
    res = res[k] if k
    res

  setStoreMetadata: (k,v) ->
    res = DS.defaultStore.typeMapFor(@).metadata
    res[k] = v

  loadMore: ->
    page = @storeMetadata('page') + 1
    @find(page: page)
    page

  hasMore: ->
    page = @storeMetadata('page')
    total = @storeMetadata('total_pages')
    unfiltered = @storeMetadata('unfiltered_total_pages')
    page < unfiltered
 
Em.ArrayController.reopen
  modelClass: ->
    res = null
    @forEach (obj) ->
      res ||= obj.constructor 
    res

  showMore: ->
    page = @modelClass().loadMore()
    @set 'lastKnownPage',page

  hasMore: (->
    if @modelClass()
      @modelClass().hasMore()
    else
      false).property('lastKnownPage','firstObject','@each','filtered.@each')
 
serializer = DS.RESTSerializer.create()
 
Em.PaginationAdapter = DS.RESTAdapter.extend
  serializer: serializer
 
DS.PaginationFixtureAdapter = DS.FixtureAdapter.extend
  findAll: (store,type) ->
    type.setStoreMetadata("page",1)

    all = @fixturesForType(type)
    res = all.slice(0,2)

    @simulateRemoteCall ->
      @didFindAll(store, type, res)
    ,@

  queryFixtures: (fixtures, query, type) ->
    page = query.page || 1
    type.setStoreMetadata("page",page)
    start = (page-1)*2

    fixtures.slice(start,start+2)

serializer.configure
  total_pages: 'total_pages'
  page: 'page'
  unfiltered_total_pages: 'unfiltered_total_pages'