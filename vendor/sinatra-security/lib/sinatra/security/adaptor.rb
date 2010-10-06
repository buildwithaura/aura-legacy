module Sinatra
  module Security
    module Adaptor
      def self.included(user)
        user.extend ClassMethods
      end

      module ClassMethods
        def user_adaptor
          return @adaptor  unless @adaptor.nil?

          if Object.const_defined?(:Sequel) and self.ancestors.include?(Sequel::Model)
            @adaptor = SequelAdaptor.new(self)

          elsif Object.const_defined?(:Ohm) and self.ancestors.include?(Ohm::Model)
            @adaptor = OhmAdaptor.new(self)

          else
            @adaptor = nil
          end
        end
      end
    end
  end
end
