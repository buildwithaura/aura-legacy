require "sinatra/content_for"

prefix = File.dirname(__FILE__)

# Load the libs; core first
Dir[File.join(prefix, 'lib/{core/,}**/*.rb')].each { |f| require f }

class Main
  register Sinatra::AuraPublic
  helpers  Sinatra::ContentFor
  use      Pistol, :files => Dir[__FILE__, root_path('{app,lib,core,extensions}/**/*.rb')]
end

# Connect to the database
DB = Sequel.connect(Main.sequel)

