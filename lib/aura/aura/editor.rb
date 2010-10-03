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

    module Fields
      def get(klass)
        begin
          const_get(klass.to_s.split('_').map(&:capitalize).join('').to_sym)
        rescue NameError
          nil
        end
      end
      module_function :get
    end

    class Field
      attr_accessor :name
      attr_accessor :title
      attr_accessor :options

      def self.create(type, name, title, options)
        klass = Fields::get(type) || Fields::Text
        klass.new(name, title, options)
      end

      def initialize(name, title, options={})
        @name = name
        @title = title
        @options = options
      end

      def inspect
        "#<Field (#{self.class.to_s.split('::').last}): '#{name}'>"
      end

      def label_html
        "<label>#{title}:</label>"
      end

      def input_html
        "<input type='text' name='#{name}' />"
      end

      def to_html
        html_wrap [ label_html, input_html ].join('')
      end

      def html_wrap(s)
        "<p>" + s + "</p>"
      end
    end

    module Fields
      class Text < Field
      end

      class Textarea < Field
        def input_html
          "<textarea type='text' name='#{name}'></textarea>"
        end
      end
    end
  end
end
