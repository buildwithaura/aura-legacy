ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require "./vendor/dependencies/lib/dependencies"
require "monk/glue"
require "./lib/nano-glue/config"
require "sequel"
require "sqlite3"

class Main < Monk::Glue
  set     :app_file, __FILE__
  use     Rack::Session::Cookie
end #class

# Sequel
DB = Sequel.connect(app_config(:sequel, :db))

Dir['./lib/aura/**/*.rb'].each { |f| require f }
Dir['./app/**/*.rb'].each { |f| require f }
Dir['./extensions/*/{*_extension.rb,{models,helpers}/*.rb}'].each { |f| require f }
Dir['./extensions/*/public'].each { |pub| Main.add_public(pub) }

if Main.development?
  Aura::Models.all.each do |model|
    klass = model.name.split('::').last
    Kernel.const_set(klass, model)
  end
end

Main.run!  if Main.run?
