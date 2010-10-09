class Main
  get '/admin' do
    require_login

    show_admin :'admin/dashboard'
  end
end
