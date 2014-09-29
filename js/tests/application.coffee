
App.rootElement = '#test-main'
App.setupForTesting()
App.injectTestHelpers()

module 'integration tests',
  setup: ->
    Ember.run ->
  teardown: ->
    App.reset()

test 'Qunit works', ->
  equal (1 + 2), 3, 'added 1 + 2 correctly'

test 'Navigation example', ->
  expect 2
  visit('/').then ->
    click('a:first').then ->
      equal find('h2').text(), 'Index template', 'The index page has correct header'
    click('a:last').then ->
      equal find('ul li:first').text(), 'Item One', 'The listing page has an item'
