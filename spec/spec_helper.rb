$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start
end

require 'rb-music'
