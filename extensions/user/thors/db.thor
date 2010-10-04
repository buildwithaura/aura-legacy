class Db
  alias _user_seed _seed

protected
  def _seed
    _user_seed

    require "ffaker"
    users = Aura::Models::User
    users.delete
    say_status :seed, users

    email = "test@sinefunc.com"
    password = "password"

    p1 = users.create :email => email,
                      :password => password,
                      :password_confirmation => password
    
    say "You may login with '#{email}' and password '#{password}'."
  end

  def lorem
    Faker::Lorem.paragraphs(3).map { |s| "<p>#{s}</p>" }.join("\n\n")
  end
end

