class Main
  set :login_user_class, lambda { Aura::Models::User }

  # The user is redirected here on first load.
  get '/admin/welcome' do
    show_admin Aura::Models::User.templates_for('edit'),
      :item   => current_user,
      :action => current_user.path(:edit),
      :first  => true
  end

  post '/login' do
    if authenticate(params)
      session[:success] = settings.login_success_message
      redirect_to_return_url
    else
      session[:error] = settings.login_error_message
      redirect settings.login_url
    end
  end

  get '/login' do
    redirect R(:admin)  if logged_in?
    if request.xhr?
      return "<div id='redirect'>#{request.fullpath}</div>"
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

  get '/user/me/edit' do
    require_login
    @item = current_user

    show_admin @item.templates_for('edit'),
      :item   => @item,
      :action => @item.path(:edit)
  end
end
