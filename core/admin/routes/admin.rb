class Main
  get '/admin' do
    require_login

    show_admin :'admin/dashboard'
  end

  get '/admin/settings' do
    show_admin :'admin/settings'
  end
end
