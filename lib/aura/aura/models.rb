module Aura
  module Models
    def all
      constants.map { |cons| const_get(cons) }
    end

    module_function :all
  end
end
