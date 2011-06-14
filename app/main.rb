prefix = File.dirname(__FILE__)

# Load the libs; core first
Dir[File.join(prefix, 'lib/{core/,}**/*.rb')].each { |f| require f }

require 'sinatra/support/multirender-ext'

class Main
  register Sinatra::AuraPublic
  register Sinatra::MultiRenderExt
  helpers  Sinatra::ContentFor
  helpers  Sinatra::UserAgentHelpers
  helpers Shield::Helpers

  set :login_success_message, nil

  register Seeder

  set :multi_views,     [root('app/views')]
  set :app_files,       Dir[root('init.rb'), root('{app,core}/**/*.rb') + root('extensions/**/*.rb')]
  set :extensions_path, [root('core'), approot('extensions')]

  use Pistol, :files => app_files + [root_path('tmp', 'restart.txt')]  unless production?

  # Heroku: override the DB config with this env var.
  set :sequel, ENV['DATABASE_URL']  unless ENV['DATABASE_URL'].nil?

  unless self.respond_to?(:sequel)
    $stderr << "No database configured. Try `rake setup` first.\n"
    exit
  end

  set :db, Sequel.connect(sequel)

  def self.restart!
    require 'fileutils'
    FileUtils.touch root_path('tmp', 'restart.txt')
  end
end

# Sequel!
Sequel::Model.plugin :aura_model
Sequel::Model.plugin :schema
Sequel::Model.plugin :auto_schema
Sequel::Model.plugin :validation_helpers
Sequel.extension :inflector

Dir[File.join(prefix, '{models,helpers,routes}/**/*.rb')].each { |f| require f }
