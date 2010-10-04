ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require "./vendor/dependencies/lib/dependencies"
require "monk/glue"
require "sinatra/content_for"
require "sequel"
require "sqlite3"
require "sinatra/security"

class Main < Monk::Glue
  set     :app_file, __FILE__
  set     :haml, :escape_html => true
  use     Rack::Session::Cookie
  helpers Sinatra::ContentFor # TODO: Move to ext/aura
  register Sinatra::Security # TODO: Move to ext/user
end #class

# Load the base extension
require './extensions/aura/aura.rb'

# Sequel
DB = Sequel.connect(app_config(:sequel, :db))

# Load extensions
Aura::Extension.all.each { |ext| ext.load! }

# Put model classes in the global namespace
Aura::Models.unload

Main.run!  if Main.run?
