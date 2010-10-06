$:.unshift(*Dir["./vendor/*/lib"])

require "rubygems"
require "sinatra/base"
require "sinatra/content_for"
require "sinatra/security"
require "sequel"
require "sqlite3"
require './extensions/aura/lib/pistol'

class Main < Sinatra::Base
  def self.root_path(*a)
    File.join(File.dirname(__FILE__), *a)
  end

  set      :app_file, __FILE__
  set      :haml, :escape_html => true
  enable   :raise_errors
  use      Rack::Session::Cookie
  helpers  Sinatra::ContentFor # TODO: Move to ext/aura
  register Sinatra::Security   # TODO: Move to ext/user
  use      Pistol, :files => Dir[__FILE__, './{app,lib,extensions}/**/*.rb']

  # Load config
  Dir[root_path('config', '*.rb')].each { |f| load f unless f.include?('.example') }
end

# Load the base extension
require './extensions/aura/aura'

# Connect to the database
DB = Sequel.connect(Main.sequel)

# Load extensions
Aura::Extension.all.each { |ext| ext.load! }

# Put model classes in the global namespace
Aura::Models.unload

Main.run!  if __FILE__ == $0
