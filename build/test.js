(function() {

  describe('sandbox', function() {
    it('Exists', function() {
      return expect(sandbox).not.be(void 0);
    });
    it('HTML', function() {
      var el;
      el = sandbox({
        html: '<p>test</p>'
      });
      return expect($(el.contentDocument.body).find('p').text()).be('test');
    });
    it('CSS', function() {
      var el;
      el = sandbox({
        css: 'body { background-color: rgb(50, 50, 50); }',
        html: '<p>test</p>'
      });
      return expect($(el.contentDocument.body).css('background-color')).be('rgb(50, 50, 50)');
    });
    it('Access global variables inside frame', function() {
      var el;
      el = sandbox({
        html: '<p>testing yay</p>',
        js: 'window.yay = 5'
      });
      return expect(el.contentWindow.yay).be(5);
    });
    it('Executes parent js', function(async) {
      var el;
      window.jsCallback = async;
      return el = sandbox({
        html: '<p>test</p>',
        js: 'parent.jsCallback()'
      });
    });
    it('Harnesses alerts', function() {
      var annoying, dialogs, noDialogs, _i, _len, _ref, _results;
      noDialogs = sandbox({
        dialogs: false
      });
      dialogs = sandbox({
        dialogs: true
      });
      _ref = ['alert', 'prompt', 'confirm'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        annoying = _ref[_i];
        expect(noDialogs.contentWindow[annoying].toString()).be('function () {}');
        _results.push(expect(dialogs.contentWindow[annoying].toString()).to.not.be('function () {}'));
      }
      return _results;
    });
    it('Includes external JS', function() {
      var el, external;
      external = ["http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js", "http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.2/underscore-min.js"];
      el = sandbox({
        html: '<p>test</p>',
        external: {
          js: external
        }
      });
      expect(el.contentWindow.jQuery).not.be(void 0);
      return expect(el.contentWindow._).not.be(void 0);
    });
    it('Includes external CSS', function() {
      var bootstrap, el;
      bootstrap = 'http://netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap.min.css';
      el = sandbox({
        html: '<p>test</p>',
        external: {
          css: [bootstrap]
        }
      });
      return expect($(el.contentDocument.body).find("link[href=\"" + bootstrap + "\"]").length).be(1);
    });
    return it('Appends to el', function() {
      var el;
      el = $('div').appendTo('body');
      sandbox({
        html: '<p>test</p>',
        el: el
      });
      return expect(el.find('iframe').length).be(1);
    });
  });

}).call(this);
