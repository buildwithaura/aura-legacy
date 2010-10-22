class Aura
  module Admin
    extend self
    def menu
      @menu ||= Menu.new
    end
  end
end
