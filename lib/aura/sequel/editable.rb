module Sequel
  module Plugins
    module AuraEditable
      def self.configure(model, opts={})
        #model.extend ClassMethods
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
    end

    module ClassMethods
    end
  end
end

