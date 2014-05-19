$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "rb-music/version"

Gem::Specification.new do |s|
  s.name        = "rb-music"
  s.version     = RBMusic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.summary     = "Music theory library for Ruby"
  s.description = "This gem provides Ruby classes for working with musical notes, scales and intervals."
  s.author      = "Mark Wise"
  s.authors     = ["Mark Wise"]
  s.email       = ["markmediadude@mgail.comm"]
  s.homepage    = "https://rubygems.org/mwise/rb-music"

  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 1.8.6"
  s.files       = ["lib/rb-music.rb"]
  s.files         += %w[README.md LICENSE]
  s.test_files    = `git ls-files -- spec/*`.split("\n")

  s.extra_rdoc_files = ['README.md']

  s.add_development_dependency("guard-rspec", "~> 4.2", ">= 4.2.8")
  s.add_development_dependency("rake", "~> 10.3", ">= 10.3.1")
  s.add_development_dependency("rspec", "~> 2.14", ">= 2.14.1")
  s.add_development_dependency("simplecov", "~> 0.8", ">= 0.8.2")
end
