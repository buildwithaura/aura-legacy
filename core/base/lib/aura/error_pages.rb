# Okay, not exactly a route. Move this please
class Aura
  module ErrorPages
    extend self

    def db_error(error)
      require 'ostruct'
      e = OpenStruct.new
      e.error       = error  unless Main.production?
      e.heading     = "Almost there!"
      e.description =
        "<p class='brief'>Your database isn't set up yet. " +
        "You may try a few things:</p>" +
        "<ul>" +
        "<li><p><x>Run <code>rake setup</code> in a console.</strong><br> <span class='muted'>(recommended)</span></p></li>" +
        "<li><span class='or'>or</span><p>If you don't have access to a console, try this:<br>" +
        "<a href='/:setup'>Continue &raquo;</a>" +
        "</p></li>" +
        "</ul>" +
        "<p class='note'>Note: If you need to set up your own database, edit the <code>config/database.rb</code> file first. You may need to do this if you believe you're seeing this in error.</p>"

      aura_error(e)
    end

    def aura_error(err)
      haml(:aura_crash).render(err)
    end

    def trace(output)
      output.gsub!(/\[[0-9;]+m/, '')

      obj = OpenStruct.new
      obj.output = output

      haml(:aura_trace).render(obj)
    end

  protected
    def template(tpl)
      fname = Main.root_path('core', 'base', 'views', "#{tpl}.haml")
      File.open(fname) { |f| f.read }
    end

    def haml(tpl)
      require 'haml'
      Haml::Engine.new(template(tpl), :escape_html => true)
    end
  end
end
