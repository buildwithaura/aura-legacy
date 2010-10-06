$:.unshift(*Dir["./vendor/*/lib"])

require "rubygems"
require "sinatra/base"
require "sequel"
require "sqlite3"

class Main < Sinatra::Base
  def self.root_path(*a)
    File.join(File.dirname(__FILE__), *a)
  end

  set      :haml, :escape_html => true
  enable   :raise_errors
  use      Rack::Session::Cookie

  Dir[root_path('config', '*.rb')].each { |f| load f unless f.include?('.example') }
end

# Bootstrap Aura
require './core/base/base'
Aura::Extension.all.each { |ext| ext.load! }
Aura::Models.unpack

Main.run!  if __FILE__ == $0
