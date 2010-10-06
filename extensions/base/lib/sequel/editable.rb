module Sequel
  module Plugins
    module AuraEditable
      module InstanceMethods
        def editable?
          true
        end
      end

      module ClassMethods
        def editable?
          true
        end

        def editor_setup(&block)
          @editor_options = nil
          editor_options.instance_eval &block
        end

        def editor_options
          @editor_options ||= Aura::Editor::ModelOptions.new(self)
        end
      end
    end
  end
end
