# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdoc/generator/json/version'

Gem::Specification.new do |spec|
  spec.name          = "rdoc-generator-json"
  spec.version       = RDocJSONGenerator::VERSION
  spec.authors       = ["Joshua Rieken"]
  spec.email         = ["joshua@joshuarieken.com"]
  spec.description   = %q{JSON generator for RDoc}
  spec.summary       = %q{Exposes a new JSON formatter for RDoc which generates a simple JSON representation of code.}
  spec.homepage      = "https://github.com/facto/rdoc-generator-json"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "rspec", "~> 2.6"
end
