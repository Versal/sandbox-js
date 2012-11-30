window.sandbox = (options = {}) ->
  options = $.extend {}, {
    html: '', css: '', js: ''
    dialogs: true
    onLog: (->)
  }, options

  { js, html, css } = options

  iframe = $('<iframe seamless sandbox="allow-scripts allow-forms allow-top-navigation allow-same-origin">').appendTo(options.el || 'body')[0]
  doc = iframe.contentDocument || iframe.contentWindow.document

  stopDialogs = "var dialogs = ['alert', 'prompt', 'confirm']; for (var i = 0; i < dialogs.length; i++) window[dialogs[i]] = function() {};"

  scripts = [js]

  unless options.dialogs
    scripts = [stopDialogs, scripts]

  allScripts = ("(function() { #{script} })();" for script in scripts).join ''


  doc.open()
  doc.write """
    #{html}
    <script>#{allScripts}</script>
    <style>#{css}</style>
  """
  doc.close()

  return iframe
