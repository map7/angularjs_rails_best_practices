describe "LettersController", ->
  beforeEach ->
    module("app")

  beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
    location = $location
    @httpBackend = $httpBackend
    @scope = $rootScope.$new()

    # mock the path /api/letters
    # @httpBackend.whenGET('/api/letters').
    #   respond([])

    @httpBackend.whenGET('/api/letters/1').
      respond(200, {subject: 'update', body: 'the body'})

    $controller("LettersController", {
      $scope: @scope,
      $location: location,
      $state: {current: {name: 'show'}},
      $stateParams: {id: 1}
    })
  ))

  it "calls /api/letters", ->
    @httpBackend.flush()
    expect(@scope.letter.subject).toEqual('update')

