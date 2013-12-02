require 'bundler/setup'
require 'es6_module_transpiler/rails'

if defined?(M)
  require 'minitest/spec'
else
  require 'minitest/autorun'
end

class MiniTest::Spec
  class << self
    alias :context :describe
  end
end
