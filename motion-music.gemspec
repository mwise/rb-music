$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "motion-music/version"

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
  s.homepage    = "https://github.com/mwise/rb-music"

  s.require_paths = ["lib"]
  s.files       = `git ls-files lib`.split($\)
  s.files       -= ["lib/rb-music.rb"]
  s.files         += %w[README.md LICENSE]

  s.extra_rdoc_files = ['README.md']
end
