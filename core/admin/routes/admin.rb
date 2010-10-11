class Main
  get '/:' do
    require_login
    show_admin :'admin/dashboard'
  end

  get '/admin' do
    require_login
    show_admin :'admin/dashboard'
  end

  get '/admin/settings' do
    require_login
    show_admin :'admin/settings'
  end
end
