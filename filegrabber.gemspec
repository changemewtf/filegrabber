# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filegrabber/version'

Gem::Specification.new do |spec|
  spec.name          = "filegrabber"
  spec.version       = FileGrabber::VERSION
  spec.authors       = ["Max Cantor"]
  spec.email         = ["max@maxcantor.net"]

  spec.summary       = %q{Quickly grab many files from a remote location.}
  spec.homepage      = "http://github.com/mcantor/filegrabber"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = "WTFPL"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"

  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "unirest", "~> 1.1"
  spec.add_dependency "thor", "~> 0.19"
end
