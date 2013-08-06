# Configure 'app' routing. The $stateProvider and $urlRouterProvider
# will be automatically injected into the configurator.
app.config ($stateProvider, $urlRouterProvider) ->

  # Make sure that any other request beside one that is already defined
  # in stateProvider will be redirected to root.
  $urlRouterProvider
    .otherwise("/")

  # Define 'app' states
  $stateProvider
    .state "default",
      abstract: true
      views:
        "":
          controller: "ApplicationController"
          templateUrl: "/assets/layouts/default.html.erb"

    # Letters
    .state "letters",
      parent: "default"
      url: "/letters"
      views:
        "":
          controller: "LettersController"
          templateUrl: "/assets/letters/index.html.erb"

    .state "new",
      parent: "letters"
      url: "/new"
      views:
        "@default":
          controller: "LettersController"
          templateUrl: "/assets/letters/new.html.erb"

    .state "edit",
      parent: "letters"
      url: "/:id/edit"
      views:
        "@default":
          controller: "LettersController"
          templateUrl: "/assets/letters/edit.html.erb"

    .state "show",
      parent: "letters"
      url: "/:id"
      views:
        "@default":
          controller: "LettersController"
          templateUrl: "/assets/letters/show.html.erb"
