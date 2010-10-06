class Main
  helpers do
    def redirect_to_return_url(session_key = :return_to, default = '/admin')
      redirect session.delete(:return_to) || default
    end
  end
end
