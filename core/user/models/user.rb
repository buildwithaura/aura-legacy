class Aura
  module Models
    class User < Model
      plugin :aura_editable

      plugin :validation_helpers

      include Sinatra::Security::User

      def slugify(str=email)
        super str
      end

      def to_s
        email
      end

      form do
        field :text,     :email, "Email", :class => 'title center'

        fieldset(:password, "Password") do
          field :password, :password, "Password", :class => 'compact'
          field :password, :password_confirmation, "Confirm", :class => 'compact'
        end
      end

      def self.seed!(type=nil, &blk)
        # Don't clear users!
        seed type, &blk
      end

      def self.seed(type=nil, &blk)
        return  if User.any?

        email    = Main.default_user
        password = Main.default_password

        p1 = self.create :email => email,
                         :password => password,
                         :password_confirmation => password

        blk.call :info, "You may login with '#{email}' and password '#{password}'."  if block_given?
      end
    end
  end
end
