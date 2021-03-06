app.controller "LettersController", ($scope, $http, $location, $state, $stateParams, searchService, flash, Letter) ->
  
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.letters = {}
  $scope.letter = {}

  # =========================================================================
  # Search using the backend (ransack)
  # =========================================================================

  $scope.search = ->
    searchService.setSubject($scope.subject_cont)
    searchService.setBody($scope.body_cont)

    # Submit the search
    $http.get('/api/letters?' +
      'q[subject_cont]=' + $scope.subject_cont +
      '&q[body_cont]=' + $scope.body_cont)
    .then ((response) ->
      $scope.letters=response.data
    )

  $scope.reset = ->
    $scope.subject_cont = ""
    $scope.body_cont = ""
    $scope.search()

  # =========================================================================
  # Index
  # =========================================================================

  if $state.current.name == 'letters'
    $scope.subject_cont = searchService.getSubject()
    $scope.body_cont = searchService.getBody()
    $scope.search()

  # =========================================================================
  # Show
  # =========================================================================

  if $state.current.name == 'show'
    Letter.get
      id: $stateParams['id']
      
    # Success
    , (response) ->
      $scope.letter = response

    # Error
    , (response) ->
      $scope.letter = response.data
  
  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    Letter.save(
      {}
    ,
      letter:
        subject: $scope.letter.subject
        body: $scope.letter.body

    # success
    , (response) ->
      flash('notice', 'Letter created!', 2000)
      $location.path "/letters"
    # failure
    , (response) ->
    )
  
  # =========================================================================
  # Edit
  # =========================================================================

  if $state.current.name == 'edit'
    Letter.get
      id: $stateParams['id']
      # success
      , (response) ->
        $scope.letter = response
      # failure
      , (response) ->

  # =========================================================================
  # Update
  # =========================================================================
    $scope.update = ->
      letter = $scope.remove_keys($scope.letter) # ApplicationController function
    
      Letter.update
        id: $stateParams['id']
      ,
        letter: letter
      # success
      , (response) ->
        flash('notice', 'Letter updated!', 2000)
        $location.path "/letters"

      # failure
      , (response) ->
        flash('alert', 'Letter not updated!', 2000)

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    Letter.delete
      id: id

    # success
    , (response) ->
      flash('notice', 'Letter deleted!', 2000)
      i=0
      while i < $scope.letters.length
        if $scope.letters[i]['id'] is id
          $scope.letters.splice(i,1)
        i++

    # failure
    , (response) ->

  return false
