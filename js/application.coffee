App = Ember.Application.create {}

App.Router.map ->
  @route "index", { path: "/" }
  @route "list", { path: "/favs" }

App.IndexController = Ember.Controller.extend
  message: 'This is a controller var'

App.ListRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set 'content', ['Item One', 'Second Item', 'Threeeeeeeeee']
