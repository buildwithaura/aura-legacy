class Aura
module Models
class User < Model
  set_schema do
    primary_key :id
    foreign_key :parent_id, :pages

    String :email
    String :slug
    String :crypted_password
    Time :last_login
  end

  plugin :aura_editable

  include Sinatra::Security::User

  def slugify(str=email)
    super str
  end

  def to_s
    email
  end

  def self.seed!(type=nil, &blk)
    # Don't clear users!
    seed type, &blk
  end

  def self.seed(type=nil, &blk)
    super
    return  if User.any?

    email    = Main.default_user
    password = Main.default_password

    p1 = self.create :email => email,
                     :password => password,
                     :password_confirmation => password

    blk.call :info, "You may login with '#{email}' and password '#{password}'."  if block_given?
  end

  seed  unless table_exists?
end
end
end
