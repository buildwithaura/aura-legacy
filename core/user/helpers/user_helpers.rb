class Main
  helpers do
    # Overridden in aura to track last login time.
    # This is called when a user logs in.
    #
    def redirect_to_return_url(session_key = :return_to, default = '/admin')
      u = current_user
      puts "-"*80
      p u.inspect
      first_login = u.last_login.nil?

      u.last_login = Time.now
      u.save

      # On a user's first login, go to a admin welcome page
      # where they can change their password.
      if first_login
        redirect R(:admin, :welcome)
      end

      redirect session.delete(:return_to) || default
    end
  end
end
