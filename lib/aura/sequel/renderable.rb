module Sequel
  module Plugins
    module AuraRenderable
      def self.configure(model, opts={})
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
    end

    module ClassMethods
    end
  end
end
