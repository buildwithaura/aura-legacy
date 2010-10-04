ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require "./vendor/dependencies/lib/dependencies"
require "monk/glue"
require "sinatra/content_for"
require "sequel"
require "sqlite3"
require "sinatra/security"

# Load the base extension
require './extensions/aura/aura.rb'

class Main < Monk::Glue
  set     :app_file, __FILE__
  set     :haml, :escape_html => true
  use     Rack::Session::Cookie
  helpers Sinatra::ContentFor
  register Sinatra::Security
  register Aura::Public
end #class

# Sequel
DB = Sequel.connect(app_config(:sequel, :db))

# Load extensions
Aura::Extension.all.each { |ext| ext.load! }

# Unload models for irb.
Aura::Models.unload  if Main.development?

Main.run!  if Main.run?
