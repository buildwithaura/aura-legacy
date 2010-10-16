class Main
  get '/admin' do
    require_login
    show_admin :'admin/dashboard'
  end

  get '/admin/settings' do
    require_login
    show_admin :'admin/settings'
  end

  get '/admin/settings/database' do
    require_login
    show_admin :'admin/settings/database'
  end

  post '/admin/settings/database/seed' do
    require_login

    Main.seed!(:sample)

    flash_message "Sample data loaded!"
    redirect R(:admin)
  end

  post '/admin/settings/database/flush' do
    require_login

    Main.flush!
    Main.auto_migrate!
    Main.seed!

    flash_message "Everything has been cleared. Welcome to your new fresh site!"

    # Log in as the test user.
    session[:user] = Aura::Models::User.first.try(:id)
    redirect R(:admin, :welcome)
  end
end
