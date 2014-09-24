
module 'integration tests',
  setup: ->
    Ember.run ->
      App.rootElement = '#app-testdiv'
      App.setupForTesting()
      App.injectTestHelpers()
      #App.reset()
  teardown: ->
    App.reset()

test 'Qunit works', ->
  equal (1 + 2), 3, 'added 1 + 2 correctly'

test 'homepage example', ->
  expect 2
  visit('/').then ->
    click('a:first').then ->
      equal find('h2').text(), 'Index template', 'The index page has correct header'
    click('a:last').then ->
      equal find('h2').text(), 'List template', 'The listing page has correct header'

