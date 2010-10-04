require "sinatra/content_for"

prefix = File.dirname(__FILE__)

# Load the libs; core first
( Dir[File.join(prefix, 'lib', 'core', '**', '*.rb')] +
  Dir[File.join(prefix, 'lib', '**', '*.rb')]
).each { |f| require f }

class Main
  register Sinatra::AuraPublic
  helpers Sinatra::ContentFor
end
