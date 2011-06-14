$:.unshift *Dir["./vendor/*/lib"]
$:.unshift *Dir["./lib"]

require "rubygems"  unless defined?(::Gem)
require "sinatra/base"
require "rtopia"
require "sequel"
require "sinatra/content_for"
require "jsfiles"
require "user_agent"
require "json"
require "yaml"

class Main < Sinatra::Base
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :root_path, lambda { |*args| root *args }
  set      :view_paths, []

  set      :haml, :escape_html => true
  set      :haml, :escape_html => true, :ugly => true  if production?

  enable   :raise_errors

  use      Rack::Session::Cookie
  helpers  Rtopia

  use      Rack::Deflater  if production?

  # Load all, but load defaults first
  ( Dir[root('config/defaults/*.rb')].sort +
    Dir[root('config/*.rb')].sort
  ).uniq.each { |f| load f }
end

# Bootstrap Aura
require './app/main'
require './app/admin'

# Load extensions
Aura::Extension.active.each { |ext| ext.load! }

seed_file = Main.root_path('config', 'seed.yml')

# If the file config/seed.yml is present, use that to initialize the DB.
# Only if the DB is pristine, though!
if File.exists?(seed_file) and !Aura::Models::Setting.table_exists?
  Aura.db_restore YAML::load_file(seed_file)

# ..otherwise, setup the database: do migrations and put in sample data.
else
  Aura::Models.all.each { |m| m.seed }
end

Aura::Models.unpack

Aura::Extension.active.each { |ext| ext.init }

Main.set :port, ENV['PORT'].to_i  unless ENV['PORT'].nil?
Main.run!  if __FILE__ == $0
