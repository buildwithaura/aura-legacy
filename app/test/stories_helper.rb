$stderr << "Stories don't work yet.\n"
exit

$:.unshift(*Dir['vendor/*/lib'])

require "rubygems"
require "contest"
require "stories"
require "stories/runner"
require "capybara"
require "capybara/dsl"

Capybara.configure do |c|
  # :culerity [headless], :selenium [firefox], :chrome
  c.default_driver = (ENV['driver'] || $_driver || :chrome).to_sym
  c.app_host       = ENV['host'] || $_host || 'http://localhost:4567'
end

Capybara.register_driver :chrome do |app|
  Capybara::Driver::Selenium.new(app, :browser => :chrome)
end

class Test::Unit::TestCase
  include Capybara
end

