sandbox = (options = {}) ->
  options = $.extend options, {
    html: '', css: '', js: ''
    stopAlerts: true
    onLog: (->)
  }

  { js, html, css } = options

  iframe = document.createElement 'iframe'
  iframe.contentDocument.write """
    <html>
      <head>
        <style>#{css}</style>
        <script>#{js}</script>
      </head>
      <body>#{html}</body>
    </html>

  """

if window?
  window.sandbox = sandbox
if module?
  module.exports = sandbox
