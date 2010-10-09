module Sequel::Plugins::AuraModel
  def self.configure(model)
    model.plugin :validation_helpers
  end

  module InstanceMethods
    def to_s
      begin
        title
      rescue NoMethodError
        @values[:title] || self.class.to_s.split('::').last
      end
    end

    def templates_for(template)
      self.class.templates_for template
    end

    def path(*a)
      ret = "/#{self.class.class_name}/#{self.id}"
      ret += "/#{a.shift.to_s}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
      ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
      ret
    end

    # Reimplemented by aura_hierarchy
    def parentable?
      false
    end

    def parent
      nil
    end

    def parent?
      ! parent.nil?
    end

    def children
      Array.new
    end
  end

  module ClassMethods
    def roots
      find_all
    end

    # Reimplemented by aura_hierarchy
    def parentable?
      false
    end

    def templates_for(template)
      [ :"#{class_name}/#{template}",
        :"base/#{template}"
      ]
    end

    def class_name
      Aura::Utils.underscorize(self.to_s)
    end

    def title
      class_name.gsub('_', ' ').capitalize
    end

    def path(*a)
      ret = "/#{class_name}"
      ret += "/#{a.shift}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
      ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
      ret
    end

  end
end

Sequel::Model.plugin :aura_model
