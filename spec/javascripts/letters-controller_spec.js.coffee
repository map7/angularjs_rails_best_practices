describe "LettersController", ->
  beforeEach ->
    module("app")

  beforeEach(inject ( ($controller, $rootScope, $location, $httpBackend) ->
    this.scope = $rootScope.$new()
    $controller("LettersController", {
      $scope: this.scope,
      $location: $location
    })
  ))

  it "it is bar", ->
    expect(this.scope.foo).toBe('bar')
    