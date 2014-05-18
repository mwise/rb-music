$LOAD_PATH.push File.expand_path("../../lib", __FILE__)
require "./version"

Gem::Specification.new do |s|
  s.name        = "motion-music"
  s.version     = MotionMusic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.summary     = "Music theory library for RubyMotion"
  s.description = "This gem wraps the rb-music gem to provide RubyMotion classes for working with musical notes, scales and intervals."
  s.author      = "Mark Wise"
  s.authors     = ["Mark Wise"]
  s.email       = ["markmediadude@mgail.comm"]
  s.files       = ["../lib/motion-music.rb"]
  s.homepage    = "https://rubygems.org/mwise/motion-music"

  s.require_paths = ["lib/motion-music"]

  s.extra_rdoc_files = ['../README.md']
end
