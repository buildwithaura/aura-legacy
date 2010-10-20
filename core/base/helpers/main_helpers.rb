class Main
  helpers do
    def h(str)
      Rack::Utils.escape_html(str)
    end

    def settings
      self.class
    end

    def select_options(items, active='', value_field=:id, name_field=:to_s)
      items.map do |item|
        selected = ''
        selected = " selected='1'"  if item == active
        [ "[%s]" % [item.try(value_field).inspect],
          "[%s]" % [active.inspect],
          "<option value='#{h item.try(value_field)}'#{selected}>",
          h(item.try(name_field)),
          "</option>" ].join('')
      end.join("\n")
    end
  end
end
