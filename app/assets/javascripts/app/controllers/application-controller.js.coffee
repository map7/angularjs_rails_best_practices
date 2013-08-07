app.controller "ApplicationController", ($scope) ->

  # Remove keys from hash to make it acceptable for Rails to update
  $scope.remove_keys = (hash) ->
    new_hash = {}
    angular.forEach(hash, (value,key) ->
      if(key!='id' && key!='created_at' && key!='updated_at')
        new_hash[key]=value
    ,  new_hash)
    return new_hash
  
