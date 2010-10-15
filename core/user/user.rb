require "sinatra/security"

class Main
  register Sinatra::Security
end

Aura::Admin.menu.add "settings.users",
  :name => "Users",
  :href => Rtopia.R(:user, :list)

