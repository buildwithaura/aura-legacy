class Main
  set :login_user_class, lambda { Aura::Models::User }

  get '/login' do
    redirect R:(admin)  if logged_in?
    if request.xhr?
      return "<div id='redirect'>/login</div>"
    end

    show 'user/login', :layout => nil
  end

  get '/logout' do
    if logged_in?
      logout!
      flash_message "You have logged out."
    end

    redirect R(:login)
  end
end
