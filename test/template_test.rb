require 'test_helper'
require 'es6_module_transpiler/tilt'
require 'execjs'

Scope = Struct.new('Scope', :root_path, :logical_path)

describe Tilt::ES6ModuleTranspilerTemplate do
  before do
    @source = <<-JS
var foo = function() {
  console.log('bar');
};

export default = foo;
JS
    @source.rstrip!
    @scope = Scope.new('', 'foo')
  end

  after do
    ES6ModuleTranspiler.compile_to = nil
    ES6ModuleTranspiler.prefix_patterns.clear
    ES6ModuleTranspiler.transform = nil
  end

  it 'transpiles es6 into amd by default' do
    expected = <<-JS
define("foo", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!

    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end

  it 'transpiles es6 into globals when set' do
    ES6ModuleTranspiler.compile_to = :globals

    expected = <<-JS
(function(__exports__) {
  "use strict";
  var foo = function() {
    console.log('bar');
  };

  __exports__.foo = foo;
})(window);
JS
    expected.rstrip!

    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end

  it 'transpiles es6 into CommonJS when set' do
    ES6ModuleTranspiler.compile_to = :cjs

    expected = <<-JS
"use strict";
var foo = function() {
  console.log('bar');
};

exports["default"] = foo;
JS
    expected.rstrip!

    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end

  it 'transpiles with a prefixed name matching a pattern' do
    ES6ModuleTranspiler.add_prefix_pattern /app/, 'app'

    expected = <<-JS
define("app/controllers/foo", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!
    @scope = Scope.new('app', 'controllers/foo')
    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected

    expected = <<-JS
define("foo", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!
    @scope = Scope.new('', 'foo')
    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end

  it "can detect multiple prefix patterns" do
    ES6ModuleTranspiler.add_prefix_pattern /app/, 'app'
    ES6ModuleTranspiler.add_prefix_pattern /config/, 'config'

    expected = <<-JS
define("app/models/foo", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!
    @scope = Scope.new('/home/user/app', 'models/foo')
    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected

    expected = <<-JS
define("config/foo", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!
    @scope = Scope.new('/home/users/config', 'foo')
    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end

  it 'transpiles es6 into amd by default' do
    expected = <<-JS
define("FOO", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var foo = function() {
      console.log('bar');
    };

    __exports__["default"] = foo;
  });
JS
    expected.rstrip!

    ES6ModuleTranspiler.transform = lambda { |name| name.upcase }
    template = Tilt::ES6ModuleTranspilerTemplate.new { @source }
    template.render(@scope).must_equal expected
  end
end
