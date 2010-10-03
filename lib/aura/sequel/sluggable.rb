# Implemented for models that are to be accessible via a slug URL,
# for example, `/products/boots`.
#
# Assumptions:
#
#  - Your table must have `String :slug`.
#
module Sequel
  module Plugins
    module AuraSluggable
      def self.configure(model, opts={})
        Aura::Slugs.register(model)
        model.extend ClassMethods
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      # Returns the URL path.
      def path(opts=nil)
        ret = '/' + slug
        ret = "#{parent.path}#{ret}"  if respond_to?(:parent) && parent.respond_to?(:id)
        ret += '?' + Aura::Utils.query_string(opts)  if opts.is_a?(Hash)
        ret
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
