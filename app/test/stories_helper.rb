$:.unshift(*Dir['vendor/*/lib'])

def require?(what, gem=what)
  require what
rescue LoadError
  $stderr << "Oops! Testing needs the #{gem} gem. Please try:\n"
  $stderr << "$ sudo gem install #{gem}\n"
  exit
end

require "rubygems"
require? "contest"
require? "stories", :stories
require? "stories/runner", :stories
require? "capybara"
require? "capybara/dsl", :capybara

Capybara.configure do |c|
  # In the future, if we want to do JS testing:
  # :culerity [headless], :selenium [firefox], :chrome
  # c.default_driver = (ENV['driver'] || $_driver || :chrome).to_sym
  # c.app_host       = ENV['host'] || $_host || 'http://localhost:4567'
  c.app = Main
end

Capybara.register_driver :chrome do |app|
  Capybara::Driver::Selenium.new(app, :browser => :chrome)
end

class Test::Unit::TestCase
  include Capybara
end
