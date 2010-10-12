class Main
  helpers do
    def h(str)
      Rack::Utils.escape_html(str)
    end

    def settings
      self.class
    end
  end
end
