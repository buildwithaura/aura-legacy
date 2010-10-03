module Aura
  module Editor
    class ModelOptions
      attr_reader :model

      def initialize(model)
        @model = model
        @fields = []
      end

      def field(name, type, options={})
        @fields << Field.new(name, type, options)
      end

      attr_reader :fields
    end

    class Field
      attr_accessor :name
      attr_accessor :type
      attr_accessor :options

      def initialize(name, type, options={})
        @name = name
        @type = type
        @options = options
      end

      def inspect
        "#<Field (#{type}): '#{name}'>"
      end
    end
  end
end
