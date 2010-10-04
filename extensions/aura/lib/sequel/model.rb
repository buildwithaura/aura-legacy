module Sequel
  module Plugins
    module AuraModel
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
          return  if slug.nil?
          ret = "/#{self.class.class_name}/#{self.id}"
          ret += "/#{a.shift.to_s}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
          ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
          ret
        end
      end

      module ClassMethods
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
  end
end

Sequel::Model.plugin :aura_model
