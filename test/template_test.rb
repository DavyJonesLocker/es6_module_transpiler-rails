require 'test_helper'
require 'es6_module_transpiler/tilt'
require 'execjs'

Scope = Struct.new('Scope', :logical_path)

describe Tilt::ES6ModuleTranspilerTemplate do
  before do
    @source = <<-JS
var foo = function() {
  console.log('bar');
};

export default = foo;
JS
    @source.rstrip!
    @scope = Scope.new('foo')
  end

  after do
    ES6ModuleTranspiler.compile_to = nil
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

  it 'transpiles es6 into global when set' do
    ES6ModuleTranspiler.compile_to = :global

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
end
