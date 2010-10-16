class Main
  helpers do
    def redirect_to_return_url(session_key = :return_to, default = '/admin')
      redirect session.delete(:return_to) || default
    end

    def authenticate(opts)
      if user = __USER__.authenticate(opts[:username], opts[:password])
        return  if session[:user] == user.id
        session[:user] = user.id

        # Added in Aura.
        u = current_user
        u.last_login = Time.now
        u.save
      end
    end
  end
end
