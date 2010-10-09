require "sequel"
require "sqlite3"
require "sinatra/content_for"

prefix = File.dirname(__FILE__)

# Load the libs; core first
Dir[File.join(prefix, 'lib/{core/,}**/*.rb')].each { |f| require f }

class Main
  register Sinatra::AuraPublic
  register Sinatra::MultiView
  helpers  Sinatra::ContentFor

  set :app_files, Dir[root_path('init.rb'), root_path('{core,extensions}/**/*.rb')]
  use Pistol, :files => app_files  unless production?

  set :extensions_path, [root_path('core'), root_path('extensions')]

  set :db, Sequel.connect(sequel)
end
