module Sequel
  module Plugins
    module AuraRenderable
      def self.configure(model, opts={})
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      def template
        @values[:template] || self.class.to_s.split('::').last.downcase
      end
    end

    module ClassMethods
    end
  end
end
