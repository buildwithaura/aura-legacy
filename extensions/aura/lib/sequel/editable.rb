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
end
