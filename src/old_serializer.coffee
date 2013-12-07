if false
  serializer = DS.RESTSerializer.create()
   
  Em.PaginationAdapter = DS.RESTAdapter.extend
    serializer: serializer

  if serializer.configure
    serializer.configure
      total_pages: 'total_pages'
      page: 'page'
      unfiltered_total_pages: 'unfiltered_total_pages'