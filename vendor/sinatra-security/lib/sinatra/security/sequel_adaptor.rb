module Sinatra
  module Security
    class SequelAdaptor
      def initialize(model)
        @model = model
      end

      # Adds a field
      def attribute(field)
      end

      def index(field)
      end

      def before_save(&blk)
        @model.class_eval do
          define_method(:before_save, blk)
        end
      end

      def write_local(instance, key, value)
        instance.instance_eval do
          @values[key] = value
        end
      end

      def find_by_login(field, login)
        @model.find(field => login)
      end
    end
  end
end

