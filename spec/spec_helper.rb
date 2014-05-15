$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start
end

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end

require 'rb-music'
