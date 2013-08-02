describe "LettersController", ->
  beforeEach ->
    module("app")

  beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
    # mock the path /api/letters
    $httpBackend.whenGET('/api/letters').respond([])

    this.scope = $rootScope.$new()
    $controller("LettersController", {
      $scope: this.scope,
      $location: $location,
      $state: {current: {name: 'show'}}
    })

  ))

  it "it is bar", ->
    expect(this.scope.foo).toBe('show')
    
