app.controller "LettersController", ($scope, $http, $location, $state, $stateParams) ->

  #
  # Initialise
  #
  $scope.letters = {}
  if $state.current.name == 'letters'
    $http.get("/api/letters").
      then((response) ->
        # success
        $scope.letters = response.data

      ), (error) ->
        # failure

  $scope.letter = {}
  if $state.current.name == 'edit'
    $http.get("/api/letters/#{$stateParams['id']}").
      then ((response) ->
        # success
        $scope.letter = response.data

      ), (error) ->
        # failure

  #
  # Create
  #
  $scope.create = ->
    $http.post("/api/letters",
      letter:
        subject: "Update Listing"
        body: "Login to update your listing"
    ).then ((response) ->
      # success
      $location.path "/letters"

    ), (error) ->
      # failure

  #
  # Update
  #
  $scope.update = ->
    $http.put("/api/letters/#{$scope.letter.id}",
      letter:
        subject: $scope.letter.subject
        body: $scope.letter.body
    ).then ((response) ->
      # success
      $location.path "/letters"

    ), (error) ->
      # failure

  #
  # Destroy
  #
  $scope.destroy = (id) ->
    $http.delete("/api/letters/#{id}").
      then ((response) ->
        # success
        $http.get("/api/letters").then ((response) ->
          $scope.letters = response.data
        ), (error) ->
          # failure
    ), (error) ->
      # failure
  
  return false
