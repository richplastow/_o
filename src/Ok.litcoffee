Ok
==

@todo describe


#### The main class for Ok

    class Ok
      C: 'Ok'
      toString: -> '[object Ok]'

      constructor: (config={}) ->
        M = "/ok/src/Ok.litcoffee
          Ok()\n  "




Constants which help minification
---------------------------------

These strings can make `*.min.js` a little shorter and easier to read, and also 
make the source code less verbose: `ok.O == typeof x` vs `'object' == typeof x`.

        @A = 'array'
        @B = 'boolean'
        #     class, not used to avoid confusion with a class’s `C` property
        @D = 'document'
        @E = 'error'
        @F = 'function'
        #     global, see build-constants, below
        #     method, not used to avoid confusion with a method’s `M` variable
        @N = 'number'
        @O = 'object'
        @R = 'regexp'
        @S = 'string'
        #     title, see build-constants, below
        @U = 'undefined'
        #     version, see build-constants, below
        @X = 'null'




Build Constants
---------------

Generated during the build-process and injected into app-scope. 

        @G = okG # global scope, passed into the closure as an argument
        @T = okT # project title, from package.json
        @V = okV # project version, from package.json




Helper Methods
--------------

- Helpers are ‘pure’ (they return the same output for a given set of arguments)
- They have no side-effects, other than throwing exceptions
- They run identically in all modern environments (browser, server, desktop, …)
- The Oopish helpers minify to xxx bytes @todo how big? and zipped?




#### `is()`
- `c <boolean>`  @todo describe
- `t <mixed>`    (optional) @todo describe
- `f <mixed>`    (optional) @todo describe
- `<mixed>`      @todo describe

Useful for reducing CoffeeScript’s verbose conditional syntax, eg:  
`if condition then 123 else 456` becomes `ok.is condition, 123, 456`. 

      is: (c, t=true, f=false) ->
        if c then t else f




#### `isU()`
@todo description

      isU: (x) ->
        'undefined' == typeof x




#### `isX()`
@todo description

      isX: (x) ->
        null == x




#### `type()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx). This can be used in 
place of JavaScript’s familiar `typeof` operator, with one important exception: 
when the variable being tested does not exist, `typeof foobar` will return 
`undefined`, whereas `ok.type(foobar)` will throw an error. 

      type: (a) ->
        return null if null == a # prevent `domwindow` in some UAs
        ta = typeof a
        return ta if { undefined:1, string:1, number:1, boolean:1 }[ta]
        if ! a.nodeName and a.constructor != Array and /function/i.test(''+a)
          return 'function' # IE<=8 http://goo.gl/bTbbov
        ({}).toString.call(a).match(/\s([a-z0-9]+)/i)[1].toLowerCase()




#### `ex()`
Exchanges a character from one set for its equivalent in another. To decompose 
an accent, use `ok.ex(c, 'àáäâèéëêìíïîòóöôùúüûñç', 'aaaaeeeeiiiioooouuuunc')`

      ex: (x, a, b) ->
        if -1 == pos = a.indexOf x then x else b.charAt pos




#### `has()`
Determines whether haystack contains a given needle. @todo arrays and objects

      has: (h, n, t=true, f=false) ->
        if -1 != h.indexOf n then t else f




#### `uid()`
Xx optional prefix. @todo description

      uid: (p) ->
        p + '_' + (Math.random()+'1111111111111111').slice 2, 18




#### `insert()`
Xx. @todo description

      insert: (basis, overlay, offset) ->
        basis.slice(0, offset) + overlay + basis.slice(offset+overlay.length)




#### `redefine()`
- `'constant'`  enumerable but immutable

Convert a property to one of XX kinds:

      redefine: (obj, name, value, kind) ->
        switch kind
          when 'constant'
            Object.defineProperty obj, name, { value:value, enumerable:true }
          when 'private'
            Object.defineProperty obj, name, { value:value, enumerable:false }




Namespaced Functions
--------------------


#### `get()`
- `global <object>`  (optional) @todo describe
- `title <string>`  (optional) @todo describe
- `version <string>`  (optional) @todo describe
- `<function>`  returns `console.log()`, with constants and methods attached

Returns a handy shortcut for `console.log()`, with all of Ok’s constants and 
methods attached. 

    Ok.get = (global, title, version) ->
      M = "/ok/src/Ok.litcoffee
        Ok.get()\n  "

Create a new instance of Ok. 

      ok = new Ok

Create a reference to `console.log()`. Note [`bind()`](http://goo.gl/66ffgl), 
and [IE8/9 behaviour](http://goo.gl/ZmG9Xs). 

      if ok.U == typeof console or ok.isU(console.log)
        out = -> # no-op
      else if ok.O == typeof console.log # eg IE8/9
        out = Function::bind console.log, console
      else
        out = console.log.bind console

Attach Ok’s properties to `out` and return it. 

      for key,val of ok
        switch key
          when 'G' then out.G = global
          when 'T' then out.T = title
          when 'V' then out.V = version
          when 'toString' then continue
          else out[key] = val
      out



    ;
