module Sequel
  module Plugins
    module AuraSluggable
      def self.configure(model, opts={})
        Aura::Slugs.register(model)
        model.extend ClassMethods
      end
    end

    module ClassMethods
      def get_by_slug(slug, parent=nil)
        pid = parent.nil? ? nil : parent.id

        if columns.include?(:parent_id)
          find(:slug => slug, parent_id: pid)
        else
          find(:slug => slug)
        end
      end
    end
  end
end
