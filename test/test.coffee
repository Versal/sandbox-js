describe 'sandbox', ->
  it 'Exists', -> expect(sandbox).not.be undefined

  it 'HTML', ->
    el = sandbox { html: '<p>test</p>' }

    expect($(el.contentDocument.body).find('p').text()).be 'test'

  it 'CSS', ->
    el = sandbox { css: 'body { background-color: rgb(50, 50, 50); }', html: '<p>test</p>' }

    expect($(el.contentDocument.body).css('background-color')).be 'rgb(50, 50, 50)'

  it 'Access global variables inside frame', ->
    el = sandbox { html: '<p>testing yay</p>', js: 'window.yay = 5' }

    expect(el.contentWindow.yay).be 5

  it 'Executes parent js', (async) ->
    window.jsCallback = async
    el = sandbox { html: '<p>test</p>', js: 'parent.jsCallback()' }

  it 'Harnesses alerts', ->
    noDialogs = sandbox { dialogs: false }
    dialogs = sandbox { dialogs: true }
    for annoying in ['alert', 'prompt', 'confirm']
      expect(noDialogs.contentWindow[annoying].toString()).be 'function () {}'
      expect(dialogs.contentWindow[annoying].toString()).to.not.be 'function () {}'

  it 'Includes external JS', ->
    external = [
      "http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"
      "http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.2/underscore-min.js"
    ]

    el = sandbox { html: '<p>test</p>', external: { js: external } }
    expect(el.contentWindow.jQuery).not.be undefined
    expect(el.contentWindow._).not.be undefined

  it 'Includes external CSS', ->
    bootstrap = 'http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap.min.css'

    el = sandbox { html: '<p>test</p>', external: { css: [bootstrap] } }
    expect($(el.contentDocument.body).find("link[href=\"#{bootstrap}\"]").length).be 1

  it 'Appends to el', ->
    el = $('div').appendTo('body')
    sandbox { html: '<p>test</p>', el }
    expect(el.find('iframe').length).be 1
