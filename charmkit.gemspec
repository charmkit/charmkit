# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'charmkit/version'

Gem::Specification.new do |spec|
  spec.name          = "charmkit"
  spec.version       = Charmkit.version
  spec.authors       = ["Adam Stokes"]
  spec.email         = ["battlemidget@users.noreply.github.com"]

  spec.summary       = %q{Helps with charm authoring}
  spec.description   = %q{}
  spec.homepage      = "http://charmkit.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "yard"
end
