DS.PaginationFixtureAdapter = DS.FixtureAdapter.extend
  setStoreMetadata: (store,type,k,v) ->
    res = store.typeMapFor(type).metadata
    res[k] = v

  findAll: (store,type) ->
    @setStoreMetadata store,type,'page',1

    all = @fixturesForType(type)
    res = all.slice(0,1)

    @setStoreMetadata store, type, 'total_pages',all.length
    @setStoreMetadata store, type, 'unfiltered_total_pages',all.length

    res
      
  queryFixtures: (fixtures, query, type) ->
    page = query.page || 1
    setStoreMetadata(@get('store'),type,"page",page) if @get('store')
    start = (page-1)*1

    fixtures.slice(start,start+1)