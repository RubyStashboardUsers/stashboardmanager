# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stashboardmanager/version'

Gem::Specification.new do |spec|
  spec.name          = "stashboardmanager"
  spec.version       = Stashboardmanager::VERSION
  spec.authors       = ["Matt Rayner"]
  spec.email         = ["matt@mattrayner.co.uk"]
  spec.summary       = %q{A manager designed to work with the stashboard-ruby gem and simplify it's use.}
  spec.description   = %q{Adds easy management to stashboard events within a ruby environment. This gem adds the ability to update stashboard only when an update is needed. i.e. creating a stashboard event with status "up" is only created when the remote status != "up" allowing you to save on Google App Engine bandwidth.}
  spec.homepage      = "https://github.com/mattrayner/stashboardmanager"
  spec.license       = "MIT"

  spec.add_dependency "stashboard-ruby"
  spec.add_development_dependency "rspec", "~> 2.6"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
