# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lj_media/version'

Gem::Specification.new do |spec|
  spec.name          = "lj_media"
  spec.version       = LJMedia::VERSION
  spec.authors       = ["Denis Misiurca"]
  spec.email         = ["infoman1985@gmail.com"]

  spec.summary       = %q{Library for extracting and processing text and media content from LJ journals}
  spec.homepage      = "https://github.com/infoman/lj_media"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "feedjira", "~> 2.0"
  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "loofah", "~> 2.0"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "contracts", "~> 0.9"

  # Require ActiveSupport for it's caching implementation
  #
  # As Rails related gems do not follow semver specification,
  # we'll allow only .patch version change, and hope it will not break
  spec.add_dependency "activesupport", "~> 4.2.1"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.2'
  spec.add_development_dependency "redcarpet", '~> 3.2'
  spec.add_development_dependency "yard", '~> 0.8.7'
  spec.add_development_dependency "yard-contracts", '~> 0.1.5'
end
