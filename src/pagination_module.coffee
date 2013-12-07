Em.PaginationModule = 
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
    #unfiltered = @storeMetadata('unfiltered_total_pages')
    unfiltered = total

    #console.debug "page #{page} total #{total} unfiltered #{unfiltered}"

    !unfiltered || page < unfiltered

  actions:
    showMore: ->
      page = @loadMore()
      @set 'lastKnownPage',page

  hasMore: (->
   @hasMoreFunc()).property('lastKnownPage','firstObject','@each','filtered.@each')