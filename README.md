# ES6ModuleTranspiler-Rails #

[![Build Status](https://secure.travis-ci.org/dockyard/es6_module_transpiler-rails.png?branch=master)](http://travis-ci.org/dockyard/es6_module_transpiler-rails)
[![Dependency Status](https://gemnasium.com/dockyard/es6_module_transpiler-rails.png?travis)](https://gemnasium.com/dockyard/es6_module_transpiler-rails)
[![Code Climate](https://codeclimate.com/github/dockyard/es6_module_transpiler-rails.png)](https://codeclimate.com/github/dockyard/es6_module_transpiler-rails)

Transpile ES6 Modules in the Rails Asset Pipeline

Uses [Square's ES6 Module Transpiler](https://github.com/square/es6-module-transpiler)

## Installation ##

**Node.js must be installed for the transpiling to happen**

```ruby
gem 'es6_module_transpiler-rails'
```

## Usage ##

Your modules will transpile and are named based upon their directory
nesting + filename, as long as the file has the `.es6` extension.
For example, `app/assets/javascripts/controllers/fooController.js.es6`

```js
var fooController = function() {
  console.log('fooController is in the house!')
};

export default = fooController;
```

will compile to `/assets/controllers/fooController.js`

```js
define("controllers/fooController",
  ["exports"],
  function(__exports__) {
    "use strict";
    var fooController = function() {
      console.log('fooController is in the house!')
    };

    __exports__["default"] = fooController;
  });
```

### Compiling ###

By default your module will compile to an AMD. You can also compile it to globals or CommonJS by making the following switch:

```ruby
ES6ModuleTranspiler.compile_to = :globals
# or
ES6ModuleTranspiler.compile_to = :cjs
```

### Custom Module Prefix ###

You can match module names based upon a pattern to apply a prefix to the
name:

```ruby
ES6ModuleTranspiler.prefix_pattern = [/^(controllers|models|views|helpers|routes|router|store)/, 'app']
```

This would match names that start with the pattern and prepend with
`app/`. For example, `controllers/fooController` would now be named
`app/controllers/fooController`.

## Authors ##

[Brian Cardarella](http://twitter.com/bcardarella)

[We are very thankful for the many contributors](https://github.com/dockyard/es6_module_transpiler-rails/graphs/contributors)

## Versioning ##

This gem follows [Semantic Versioning](http://semver.org)

## Want to help? ##

Please do! We are always looking to improve this gem.

## Legal ##

[DockYard](http://dockyard.com), LLC &copy; 2013

[@dockyard](http://twitter.com/dockyard)

[Licensed under the MIT license](http://www.opensource.org/licenses/mit-license.php)
