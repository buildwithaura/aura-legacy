module Sequel
  module Plugins
    module AuraModel
      def self.configure(model, opts={})
        model.extend ClassMethods
        model.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def to_s
          begin
            title
          rescue NoMethodError
            @values[:title] || self.class.to_s.split('::').last
          end
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
      end
    end
  end
end

Sequel::Model.plugin :aura_model
