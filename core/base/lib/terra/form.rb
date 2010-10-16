module Terra
  class Form
    def initialize
      @fieldsets = Hash.new
      fieldset(:default) { }
    end

    alias configure instance_eval

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
