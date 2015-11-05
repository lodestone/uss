# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uss/version'

Gem::Specification.new do |spec|
  spec.name          = "uss"
  spec.version       = USS::VERSION
  spec.authors       = ["Matthew Petty"]
  spec.email         = ["matt@kizmeta.com"]
  spec.description   = %q{Universal String Searcher}
  spec.summary       = %q{a wrapper for searching large corpora/dictionaries for esoterica}
  spec.homepage      = "http://github.com/lodestone/uss"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
