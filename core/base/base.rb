require "sinatra/content_for"
require "json"

prefix = File.dirname(__FILE__)

# Load the libs; core first
Dir[File.join(prefix, 'lib/{core/,}**/*.rb')].each { |f| require f }

class Main
  register Sinatra::AuraPublic
  register Sinatra::MultiView
  helpers  Sinatra::ContentFor
  register Seeder

  set :app_files,       Dir[root_path('init.rb'), root_path('{core,extensions}/**/*.rb')]
  set :extensions_path, [root_path('core'), root_path('extensions')]

  use Pistol, :files => app_files + [root_path('tmp', 'restart.txt')]  unless production?

  # Heroku: override the DB config with this env var.
  set :sequel, ENV['DATABASE_URL']  unless ENV['DATABASE_URL'].nil?

  unless self.respond_to?(:sequel)
    $stderr << "No database configured. Try `rake setup` first.\n"
    exit
  end

  set :db, Sequel.connect(sequel)
end

# Sequel!
Sequel::Model.plugin :aura_model
Sequel::Model.plugin :schema
Sequel::Model.plugin :validation_helpers
Sequel.extension :inflector
