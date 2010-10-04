module Aura
  module Models
    class User < Model
      #plugin :aura_sluggable
      plugin :aura_editable

      plugin :validation_helpers

      include Sinatra::Security::User

      def slugify(str=email)
        super str
      end

      alias to_s email
    end
  end
end
