class Main
  helpers do
    def h(str)
      Rack::Utils.escape_html(str)
    end
  end
end
