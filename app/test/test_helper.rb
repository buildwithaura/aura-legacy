ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'init'))

def require?(what, gem=what)
  require what
rescue LoadError
  $stderr << "Oops! Testing needs the #{gem} gem. Please try:\n"
  $stderr << "$ sudo gem install #{gem}\n"
  exit
end

require? "rack/test", "rack-test"
require? "contest"

class Test::Unit::TestCase
  include Rack::Test::Methods
  include Rtopia

  def setup
    Main.flush!
  end

  def app
    Main.new
  end
end
