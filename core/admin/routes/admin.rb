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
    logout!
    flash_message "Everything cleared. Log on with the default user now."
    redirect R(:login)
  end
end
