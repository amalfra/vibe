# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vibe/version'

Gem::Specification.new do |spec|
  spec.name          = "vibe"
  spec.version       = Vibe::VERSION
  spec.authors       = ["Amal Francis"]
  spec.email         = ["amalfra@gmail.com"]
  spec.summary       = %q{A Ruby wrapper for the Vibe REST API}
  spec.description   = %q{A Ruby wrapper for the Vibe REST API}
  spec.homepage      = "https://github.com/amalfra/vibe"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.7.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
