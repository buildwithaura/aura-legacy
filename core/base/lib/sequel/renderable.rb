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
      module InstanceMethods
        # Returns the templates to be tried for the item, listed
        # in order of priority.
        #
        # Example:
        #
        #     [ "product/mofo", "base/mofo", "product/default", "base/default" ]
        #
        def page_templates
          klass = self.class.class_name # blog_post

          [ :"#{klass}/#{template}",
            :"base/#{template}",
            :"#{klass}/default",
            :"base/default"
          ].map { |s| s.to_sym }.uniq
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
    end
  end
end
