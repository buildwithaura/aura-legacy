class Aura
  module Editor
    # DSL thing
    #
    # Example:
    #
    #   form = Form.new
    #
    #   form.configure do
    #     text :name, "Name"
    #     text :email, "Email address"
    #
    #     fieldset :options, "Options" do
    #       textarea :body, "Body", :class => "hello"
    #       select   :type, "Type",
    #         :options => {
    #           :red => "Red",
    #           :blue => "Blue"
    #         }
    #     end
    #   end
    #
    #   -# HAML
    #   - form.fieldsets.each do |set|
    #     = set.to_s
    #     - set.fields.each do |field|
    #       = field.to_html
    #
    #   -# Also some useful methods:
    #
    #   = form.fieldsets.first.to_html
    #   = form.fieldsets.first.fields.first.to_html
    #
    #   = form.fieldset(:default).to_html
    #   = form.fieldset(:default).field(:name).to_html
    #
    class Form
      def initialize
        @fieldsets = Hash.new
        fieldset(:default) { }
      end

      def configure(&block)
        self.instance_eval &block
      end

      def fieldset(id, name=nil, options={}, &block)
        return @fieldsets[id]  unless block_given?

        @fieldsets[id] ||= Fieldset.new(self, id, name, options)
        @fieldsets[id].instance_eval &block
      end

      # Forwardable
      def field(*a) fieldset(:default).field *a; end
      Fields.all.each do |type|
        define_method(type) { |*a| field type, *a }
      end

      def fieldsets
        @fieldsets.values.sort_by { |fs| fs.to_s }
      end
    end
  end
end
