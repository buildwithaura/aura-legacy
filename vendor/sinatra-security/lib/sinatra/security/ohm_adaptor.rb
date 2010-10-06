module Sinatra
  module Security
    class OhmAdaptor
      def initialize(model)
        @model = model
        model.send :include, Validations
      end

      # Adds a field
      def attribute(field)
        @model.attribute field
      end

      # Adds an index
      def index(field)
        @model.index field
      end

      # Define a callback to be called before saving
      def before_save(&blk)
        @model.class_eval do
          # @private internally called by Ohm after validation when persisting.
          define_method(:write, blk)
        end
      end

      # Sets a field to a value
      def write_local(instance, key, value)
        instance.instance_eval do
          write_local key, value
        end
      end

      def find_by_login(field, login)
        @model.find(field => login).first
      end
    end
  end
end
