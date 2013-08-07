app.factory "Letter", ($resource, apiPrefix) ->
  $resource(apiPrefix + "/letters/:id",
    id: "@id"
  ,
    update:
      method: "PUT"
  )



  
  
