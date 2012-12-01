# Sandbox.js

Sandbox.js is a tiny library that runs code in a sandboxed environment, by sticking it in an iframe. It creates a global function called sandbox() which returns an iframe.

## Options
```

// Options passed as the first argument to sandbox. Defaults are listed.
{
  // iframe html
  html: '',
  // iframe css
  css: : '',
  // iframe js
  js: '',
  // whether to allow dialogs such as alert/confirm/prompts
  dialogs: true,
  external: {
    // array of external js libraries ie. jQuery
    js: [],
    // array of external js libraries ie. Bootstrap
    css: []
  },
}
```
