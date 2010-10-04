require "sinatra/security"

class Main
  register Sinatra::Security # TODO: Move to ext/user
end
