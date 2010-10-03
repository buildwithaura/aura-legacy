module Aura
  module Editor
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
  end
end

