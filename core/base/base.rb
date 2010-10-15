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

  register AutoMigrator

  set :app_files, Dir[root_path('init.rb'), root_path('{core,extensions}/**/*.rb')]
  use Pistol, :files => app_files  unless production?

  set :extensions_path, [root_path('core'), root_path('extensions')]

  # Heroku
  set :sequel, ENV['DATABASE_URL']  if ENV.keys.include? 'DATABASE_URL'

  unless self.respond_to?(:sequel)
    puts "No database configured. Try `rake setup` first."
    exit
  end

  set :db, Sequel.connect(sequel)
  
  set :scss, { :load_paths => [ root_path, root_path('core'), root_path('extensions'), root_path('vendor/compass_framework') ] }
  set :scss, self.scss.merge(:line_numbers => true, :debug_info => true, :always_check => true) if self.development?
  set :scss, self.scss.merge(:style => :compressed) if self.production?
end
