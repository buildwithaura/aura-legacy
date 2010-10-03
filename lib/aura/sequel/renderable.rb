# Models that can be viewed by a URL.
# Supports templating and stuff.
#
# Assumptions:
#
# - Your data table must have `String :template`. (optional;
#   guesses template if not available)
#
module Sequel
  module Plugins
    module AuraRenderable
      def self.configure(model, opts={})
        model.send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      def template
        @values[:template] || default_template
      end

      def default_template
        self.class.to_s.split('::').last.downcase
      end

      def renderable?
        true
      end
    end

    module ClassMethods
    end
  end
end
