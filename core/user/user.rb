require "sinatra/security"

class Main
  register Sinatra::Security
  set :login_success_message, nil
end

Aura::Admin.menu.add "settings.your_account",
  :name => "Your account",
  :href => Rtopia.R(:user, :me, :edit)

Aura::Admin.menu.add "settings.users",
  :name => "Users",
  :href => Rtopia.R(:user, :list)

