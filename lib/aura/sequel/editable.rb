module Sequel
  module Plugins
    module AuraEditable
      def self.configure(model, opts={})
        model.extend ClassMethods
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      def editable?
        true
      end
    end

    module ClassMethods
      def editor_setup(&block)
        e = Aura::Editor::ModelOptions.new(self)
        e.instance_eval &block
        @editor_options = e
      end

      def editor_options
        @editor_options
      end
    end
  end
end
