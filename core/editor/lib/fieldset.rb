class Aura
  module Editor
    class Fieldset
      def initialize(form, id, name=nil, options={})
        @form   = form
        @id     = id
        @name   = name
        @fields = []
      end

      # Add (or get?) a field
      def field(type, id, title, options={})
        @fields << Field.create(type, id, title, options)
      end

      def to_s
        @name || @id.to_s.capitalize
      end

      def inspect
        "#<Fieldset #{@id.inspect} [fields: #{fields.inspect}]>"
      end

      def default?
        @id == :default
      end

      def to_html
        [ "<fieldset>",
          ("<h3 class='legend'>#{self.to_s}</h3>" unless default?),
          fields.map { |f| f.to_html },
          "</fieldset>" ].join("\n")
      end

      attr_reader :fields
      attr_reader :id

      Fields.all.each do |type|
        define_method(type) { |*a| field type, *a }
      end
    end
  end
end

