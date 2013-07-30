app.controller "LettersController", ($scope, $http, $location, $state, $stateParams) ->

  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.letters = {}
  if $state.current.name == 'letters'
    $http.get("/api/letters"

    # success
    ).then ((response) ->
      $scope.letters = response.data

    # failure
    ), (error) ->
      
  $scope.letter = {}
  if $state.current.name == 'edit'
    $http.get("/api/letters/#{$stateParams['id']}"

    # success
    ).then ((response) ->
      $scope.letter = response.data

    # failure
    ), (error) ->

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    $http.post("/api/letters",
      letter:
        subject: $scope.letter.subject
        body: $scope.letter.body

    # success
    ).then ((response) ->
      $location.path "/letters"

    # failure
    ), (error) ->

  # =========================================================================
  # Update
  # =========================================================================

  $scope.update = ->
    debugger
  
    $http.put("/api/letters/#{$scope.letter.id}",
      letter:
        subject: $scope.letter.subject
        body: $scope.letter.body
      
    # success
    ).then ((response) ->
      $location.path "/letters"

    # failure
    ), (error) ->

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    $http.delete("/api/letters/#{id}"

    # success
    ).then ((response) ->
      $http.get("/api/letters").then ((response) ->
        $scope.letters = response.data
      ), (error) ->

    # failure
    ), (error) ->

  return false