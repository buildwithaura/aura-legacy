# Okay, not exactly a route. Move this please
class Aura
  module ErrorPages
    extend self

    def db_error
      require 'ostruct'
      e = OpenStruct.new
      e.heading     = "Something's not right."
      e.description =
        "Aura has encountered a database error. " +
        "Try running <code>rake setup</code>, then " +
        "restart the application."

      aura_error(e)
    end

    def aura_error(err)
      require 'haml'
      fname    = Main.root_path('core', 'base', 'views', 'aura_crash.haml')
      template = File.open(fname) { |f| f.read }

      Haml::Engine.new(template).render(err)
    end
  end
end
