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
      def path(*a)
        return  if slug.nil?
        ret = '/' + (slug.to_s)
        ret = "#{parent.path}#{ret}"  if respond_to?(:parent) && parent.respond_to?(:id)
        ret += "/#{a.shift.to_s}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
        ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
        ret
      end

      # Returns a unique slug for the item.
      def slugify
        str = title.scan(/[A-Za-z0-9]+/).join('-').downcase
        i = 1

        loop do
          slug = str
          slug = "#{str}-#{i}"  if i>1

          item = self.class.find(:slug => slug)
          return slug  if item.nil? || item == self
          i += 1
        end
      end

      def validate
        self.slug = self.slugify  if self.slug.nil? or self.slug.empty?
        super
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

      def path(*a)
        ret = "/#{class_name}"
        ret += "/#{a.shift}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
        ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
        ret
      end

      def class_name
        Aura::Utils.underscorize(self.to_s)
      end
    end
  end
end
