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

      attr_reader :fields
      attr_reader :id
    end
  end
end

