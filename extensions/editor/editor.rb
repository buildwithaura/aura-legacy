module Aura
  module Editor
    class ModelOptions
      attr_reader :model

      def initialize(model)
        @model = model
        @fields = []
      end

      def field(type, name, title, options={})
        @fields << Field.create(type, name, title, options)
      end

      attr_reader :fields
    end

    PREFIX = File.dirname(__FILE__)

    autoload :Field,  "#{PREFIX}/lib/field"
    autoload :Fields, "#{PREFIX}/lib/fields"
  end
end
