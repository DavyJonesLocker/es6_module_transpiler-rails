# Es6ModuleTranspiler-Rails #

Transpile ES6 Modules in the Rails Asset Pipeline

## Installation ##

**Node.js must be installed for the transpiling to happen**

```ruby
gem 'es6_module_transpiler-rails'
```

## Usage ##

Your modules will transpile are named based upon their directory
nesting + filename, as long as the file has the `.es6` extension.
For example, `app/assets/javascripts/controllers/fooController.js.es6`

```js
var fooController = function() {
  console.log('fooController is in the house!')
};

export default = fooController;
```

will compile to

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
