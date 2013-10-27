require 'es6_module_transpiler/rails/version'
require 'es6_module_transpiler/tilt'
require 'es6_module_transpiler/sprockets'

module ES6ModuleTranspiler
  def self.compile_to
    @compile_to || :amd
  end

  def self.compile_to=(target)
    @compile_to = target
  end
end
