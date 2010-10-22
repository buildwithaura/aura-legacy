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

  def p(obj)
    return unless ENV['verbose']
    str = obj.is_a?(String) ? obj : obj.inspect
    file, line = p_source
    basename = File.basename(file)

    puts "\033[1;32m%20s\033[1;30m:%-3s\033[0m %s" % [basename, line, str]
  end


  # @return [Array] [ app/test/unit/migration_test.rb, 23 ]
  def p_source
    backtrace[2].split(':')[0..1]
  end

  def backtrace
    raise 1
  rescue => e
    e.backtrace[2..-1]
  end
end
