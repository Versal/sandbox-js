require './should'
require 'jquery'
sandbox = require '../sandbox'

describe 'sandbox', ->
  it 'exists', -> sandbox.should.exist

  it 'html', ->
    el = sandbox { html: '<p>test</p>' }

    $(el.contentDocument).find('p').text().should.eql 'test'

  it 'css', ->
    el = sandbox { css: 'body { background-color: #333; }', html: '<p>test</p>' }

    $(el.contentDocument).find('body').css('background-color').should.eql '#333'

  it 'js', ->
    el = sandbox { html: '<p>test</p>', js: 'window.foo = 5' }

    el.contentWindow.foo.should.eql 5

  it 'executes parent js', (async) ->
    el = sandbox { html: '<p>test</p>', js: 'parent.jsCallback()' }
    window.jsCallback = async

  it 'harnesses alerts', ->
    noAlerts = sandbox { stopAlerts: true }
    alerts = sandbox { stopAlerts: false }
    for annoying in ['alert', 'prompt', 'confirm']
      noAlerts.contentWindow[annoying].toString().should.eql 'function () {}'
      alerts.contentWindow[annoying].toString().shouldnt.eql 'function () {}'

  it 'harnesses consoles', (async) ->
    sandbox {
      onLog: (say) ->
        async() if say is 'hi'

      js: 'console.log("hi");'
    }
