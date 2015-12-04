# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sc1602_for_bbb/version'

Gem::Specification.new do |spec|
  spec.name          = "sc1602_for_bbb"
  spec.version       = SC1602ForBBB::VERSION
  spec.authors       = ["shiftky"]
  spec.email         = ["shiftky@gmail.com"]

  spec.summary       = %q{SC1602 character LCD display library for BeagleBone Black}
  spec.description   = %q{SC1602 character LCD display library for BeagleBone Black}
  spec.homepage      = "https://github.com/shiftky/sc1602_for_bbb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "beaglebone"
end
