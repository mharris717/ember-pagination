Em.ArrayController.reopen
  modelClass: ->
    @modelInfo.class
  modelNameForStore: ->
    @modelInfo.store

  storeMetadata: (k) ->
    res = @store.typeMapFor(@modelClass()).metadata
    res = res[k] if k
    res

  setStoreMetadata: (k,v) ->
    res = @store.typeMapFor(@modelClass()).metadata
    res[k] = v

  loadMore: ->
    page = @storeMetadata('page') + 1
    @setStoreMetadata('page',page)
    @store.findQuery(@modelNameForStore(),page: page)
    page

  hasMoreFunc: ->
    page = @storeMetadata('page')
    total = @storeMetadata('total_pages')
    unfiltered = @storeMetadata('unfiltered_total_pages')
    page < unfiltered

  showMore: ->
    page = @loadMore()
    @set 'lastKnownPage',page

  hasMore: (->
   @hasMoreFunc()).property('lastKnownPage','firstObject','@each','filtered.@each')

DS.PaginationFixtureAdapter = DS.FixtureAdapter.extend
  setStoreMetadata: (store,type,k,v) ->
    res = store.typeMapFor(type).metadata
    res[k] = v

  findAll: (store,type) ->
    @setStoreMetadata store,type,'page',1

    all = @fixturesForType(type)
    res = all.slice(0,1)

    res
      
  queryFixtures: (fixtures, query, type) ->
    page = query.page || 1
    setStoreMetadata(@get('store'),type,"page",page) if @get('store')
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