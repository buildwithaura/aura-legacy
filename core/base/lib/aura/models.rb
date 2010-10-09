module Aura
  module Models
    extend self

    def all
      constants.map { |cons| const_get(cons) }
    end

    def get(item)
      item = camelize(item)  if item.downcase == item
      begin
        const_get(item)
      rescue NameError
        nil
      end
    end

    # Puts models in the global namespace.
    def unpack
      all.each do |model|
        klass = model.name.split('::').last
        Kernel.const_set(klass, model)  unless Kernel.const_defined?(klass)
      end
    end

  protected
    def camelize(str)
      str.split('_').map { |s| s.capitalize }.join('')
    end
  end
end
