$:.unshift(*Dir['./vendor/*/lib'])

def require?(what, gem=what)
  require what
rescue LoadError => e
  $stderr << "Oops! Testing needs the #{gem} gem. Please try:\n"
  $stderr << "$ sudo gem install #{gem}\n"
  raise e
end

require "rubygems"
require? "contest"
require? "capybara"
require? "capybara/dsl", :capybara

require "test_helper"

Capybara.app = Main

if ENV['driver'] == 'chrome'
  Capybara.default_driver = (ENV['driver'] || :chrome).to_sym
  Capybara.register_driver :chrome do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
  end
end

class Test::Unit::TestCase
  include Capybara

  def status
    p "Current path", current_path
  end

  def assert_location(loc)
    assert_equal loc, current_path
  end

  setup do
    Main.flush!
    Main.seed!
  end
end
