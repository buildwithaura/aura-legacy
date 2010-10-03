ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require "./vendor/dependencies/lib/dependencies"
require "monk/glue"
require "./lib/nano-glue/config"
require "sequel"
require "sqlite3"
require './extensions/aura/aura.rb'

Dir['./lib/*.rb'].each { |f| require f }

class Main < Monk::Glue
  set     :app_file, __FILE__
  use     Rack::Session::Cookie

  register Aura::Public

  set :haml, :escape_html => true
  set :views, root_path('extensions', 'base', 'views')
end #class

# Sequel
DB = Sequel.connect(app_config(:sequel, :db))

Dir['./app/**/*.rb'].each { |f| require f }
Aura.extensions.each { |ext| ext.load! }

# Unload models for irb
if Main.development?
  Aura::Models.all.each do |model|
    klass = model.name.split('::').last
    Kernel.const_set(klass, model)
  end
end

Main.run!  if Main.run?
