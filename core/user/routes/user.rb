class Main
  set :login_user_class, lambda { Aura::Models::User }

  get '/login' do
    redirect '/'  if logged_in?
    show 'user/login', :layout => nil
  end

  get '/logout' do
    if logged_in?
      logout!
      flash_message "You have logged out."
    end

    redirect '/login'
  end
end
