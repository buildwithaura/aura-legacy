ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require "./vendor/dependencies/lib/dependencies"
require "monk/glue"
require "sequel"
require "sqlite3"

# Load the base extension
require './extensions/aura/aura.rb'

class Main < Monk::Glue
  set     :app_file, __FILE__
  use     Rack::Session::Cookie

  register Aura::Public

  set :haml, :escape_html => true
end #class

# Sequel
DB = Sequel.connect(app_config(:sequel, :db))

# Load extensions
Aura.extensions.each { |ext| ext.load! }

# Unload models for irb
if Main.development?
  Aura::Models.all.each do |model|
    klass = model.name.split('::').last
    Kernel.const_set(klass, model)
  end
end

Main.run!  if Main.run?
