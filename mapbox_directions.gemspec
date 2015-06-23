# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapbox_directions/version'

Gem::Specification.new do |spec|
  spec.name          = "mapbox_directions"
  spec.version       = MapboxDirections::VERSION
  spec.authors       = ["yonelacort"]
  spec.email         = ["yonedev@gmail.com"]
  spec.summary       = %q{MapBox Directions API}
  spec.description   = %q{Ruby wrapper for the MapBox Directions Service}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "polylines"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "ruby_gntp"
end
