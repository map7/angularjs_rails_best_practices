describe "LettersController", ->
  beforeEach ->
    module("app")

  beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
    @location = $location
    @httpBackend = $httpBackend
    @scope = $rootScope.$new()

      # mock the path /api/letters
      # @httpBackend.whenGET('/api/letters').
      #   respond([])
  ))

  describe "show", ->
    beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
      @httpBackend.whenGET('/api/letters/1').respond(200, {subject: 'update', body: 'the body'})

      $controller("LettersController", {
        $scope: @scope,
        $location: @location,
        $state: {current: {name: 'show'}},
        $stateParams: {id: 1}
      })
    ))

    it "Returns letter object", ->
      @location.path('/letters/1')
      @httpBackend.flush()      # Flush pending tasks before testing output.
      expect(@scope.letter.subject).toEqual('update')
      expect(@scope.letter.body).toEqual('the body')

  describe "create", ->
    beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
      @redirect = spyOn($location, 'path')
      @httpBackend.whenGET('/assets/layouts/default.html.erb').respond(200)
      @httpBackend.whenGET('/assets/letters/index.html.erb').respond(200)
      @httpBackend.whenPOST('/api/letters').respond(200)
  
      $controller("LettersController", {
        $scope: @scope,
        $location: @location,
        $stateParams: {id: 1}
      })
    ))

    it "redirects to /letters", ->
      # arrange
      @httpBackend.expectPOST('/api/letters', {"letter":{},"_utf8":"☃"}).respond(200)

      # act
      @scope.create()
      @httpBackend.flush()

      # assertions
      expect(@redirect).toHaveBeenCalledWith('/letters')

