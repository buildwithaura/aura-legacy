# Models that can be viewed by a URL.
# Supports templating and stuff.
#
# Assumptions:
#
# - Your data table must have `String :template`. (optional;
#   Aura guesses the template name if it's not available.)
#
module Sequel
  module Plugins
    module AuraRenderable
      def self.configure(model, opts={})
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      def templates_for(template)
        self.class.templates_for template
      end

      def page_templates
        [template, default_template, :default].map(&:to_sym).uniq
      end

      def template
        @values[:template] || default_template
      end

      def default_template
        self.class.class_name
      end

      def renderable?
        true
      end
    end

    module ClassMethods
    end
  end
end
