# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'page_for/version'

Gem::Specification.new do |spec|
  spec.name          = "page_for"
  spec.version       = PageFor::VERSION
  spec.authors       = ["jrhicks", "jbarket"]
  spec.email         = ["jrhicks@cteh.com", "jbarket@sleepunit.com"]
  spec.summary       = %q{Themable helpers for building web interfaces.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
