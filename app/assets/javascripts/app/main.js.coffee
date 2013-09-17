# Create 'app' angular application (module)
# ngResource (angular-resource) = Helps you setup your RESTful routes
# ui.compat (angular-ui-states) = Keeps state
@app = angular.module("app", [

  # ngResource for talking to RESTful servers
  "ngResource",

  # AngularJS router
  "ui.compat",

  # Flash messages
  "flash"
])


