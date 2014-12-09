# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'es6_module_transpiler/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "es6_module_transpiler-rails"
  spec.version       = ES6ModuleTranspiler::Rails::VERSION
  spec.authors       = ["Brian Cardarella"]
  spec.email         = ["bcardarella@gmail.com"]
  spec.summary       = %q{ES6 Module Transpiler for Rails}
  spec.description   = %q{Compile ES6 modules in the asset pipeline}
  spec.homepage      = "https://github.com/dockyard/es6_module_transpiler-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'execjs'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'tilt'
  spec.add_development_dependency 'sprockets', '> 2.0.0'
  spec.add_development_dependency 'minitest'
end
