app.controller "LettersController", ($scope, $http, $location, $state, $stateParams, Letter) ->
  
  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.letters = {}
  $scope.letter = {}
  $scope.foo = $state.current.name

  # =========================================================================
  # Index
  # =========================================================================

  if $state.current.name == 'letters'
    Letter.query(
      {}
    # success
    , (response) ->
      $scope.letters = response

    # failure
    , (response) ->
    )

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
    letter = {}
    #  Strip out id, created_at & updated_at
    angular.forEach($scope.letter, (value,key) ->
      if(key!='id' && key!='created_at' && key!='updated_at')
        letter[key]=value
    ,letter)
  
    Letter.update
      id: $stateParams['id']
    ,
      letter: letter
    # success
    , (response) ->
      $location.path "/letters"

    # failure
    , (response) ->

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    Letter.delete
      id: id

    # success
    , (response) ->
      i=0
      while i < $scope.letters.length
        if $scope.letters[i]['id'] is id
          $scope.letters.splice(i,1)
        i++

    # failure
    , (response) ->

  return false
