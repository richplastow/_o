Export Module
=============

#### The module’s only entry-point is the `Ok` class

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if 'function' == typeof define and define.amd
      define -> Ok

Next, try exporting for CommonJS, eg for [Node.js](http://goo.gl/Lf84YI):  
`var Ok = require('ok');`

    else if 'object' == typeof module and module and module.exports
      module.exports = Ok

Otherwise, add the `Ok` class to global scope.  
Browser usage: `var ok = new window.Ok();`

    else okG.Ok = Ok # `okG` is an argument passed to the outermost closure


    ;

