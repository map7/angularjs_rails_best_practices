describe "LettersController", ->
  beforeEach ->
    module("app")

  beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
    @location = $location
    @httpBackend = $httpBackend
    @scope = $rootScope.$new()
  ))

  # =========================================================================
  # Index tests
  # =========================================================================

  describe "index", ->
    beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->

      # mock the path /api/letters
      @httpBackend.whenGET('/api/letters').respond(200, letters: {subject: "update"})

      $controller("LettersController", {
        $scope: @scope,
        $location: @location,
        $state: {current: {name: 'letters'}},
        $stateParams: {id: 1}
      })
    ))

    it "Returns letters array", ->
      @httpBackend.flush()
      expect(@scope.letters[0].subject).toEqual('update')
    
  # =========================================================================
  # Show tests
  # =========================================================================

  describe "show", ->
    describe "when good", ->
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
        @httpBackend.flush()      # Flush pending tasks before testing output.
        expect(@scope.letter.subject).toEqual('update')
        expect(@scope.letter.body).toEqual('the body')

    describe "when error", ->
      beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
        @httpBackend.whenGET('/api/letters/1').respond(401, {error: 'no data'})

        $controller("LettersController", {
          $scope: @scope,
          $location: @location,
          $state: {current: {name: 'show'}},
          $stateParams: {id: 1}
        })
      ))

      it "Returns letter object", ->
        @httpBackend.flush()      # Flush pending tasks before testing output.
        expect(@scope.letter.error).toEqual('no data')

  # =========================================================================
  # Create tests
  # =========================================================================

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
    
                               
    # ================================================================================
    # Delete tests
    # ================================================================================

    describe "destroy", ->
      beforeEach(inject ( ($controller, $rootScope, $location, $state, $httpBackend) ->
        # mock path /letters
        #@httpBackend.whenGET('/api/letters/1').respond(200, {tran_no: 1, voucher_no: 2})
        
        ctrl = $controller('LettersController', {
          $scope: @scope,
          $location: @location
        })
      ))
      
      it "gets a new listing from the server", ->
     
        @scope.letters = [{id: 1, tran_no: 1}, {id: 2, tran_no: 2}]
        
        @httpBackend.expectDELETE('/api/letters/1').respond(200)
        @scope.destroy(1)

        @httpBackend.flush()    # Flush pending tasks before testing output
        #expect(@scope.letters[0].tran_no).toEqual(1)
        expect(@scope.letters).toEqual([{id: 2, tran_no: 2}])
        
#      it "removes letter from the list", ->
        
