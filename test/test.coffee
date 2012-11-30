describe 'sandbox', ->
  it 'Exists', -> expect(sandbox).to.exist

  it 'HTML', ->
    el = sandbox { html: '<p>test</p>' }

    expect($(el.contentDocument.body).find('p').text()).to.be 'test'

  it 'CSS', ->
    el = sandbox { css: 'body { background-color: rgb(50, 50, 50); }', html: '<p>test</p>' }

    expect($(el.contentDocument.body).css('background-color')).to.be 'rgb(50, 50, 50)'

  it 'Access global variables inside frame', ->
    el = sandbox { html: '<p>testing yay</p>', js: 'window.yay = 5' }

    expect(el.contentWindow.yay).to.be 5

  it 'executes parent js', (async) ->
    window.jsCallback = async
    el = sandbox { html: '<p>test</p>', js: 'parent.jsCallback()' }

  it 'harnesses alerts', ->
    noDialogs = sandbox { dialogs: false }
    dialogs = sandbox { dialogs: true }
    for annoying in ['alert', 'prompt', 'confirm']
      expect(noDialogs.contentWindow[annoying].toString()).to.be 'function () {}'
      expect(dialogs.contentWindow[annoying].toString()).to.not.be 'function () {}'

  it 'appends to el', ->
    el = $('div').appendTo('body')
    sandbox { html: '<p>test</p>', el }
    expect(el.find('iframe').length).to.be 1
