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

  # Implements the world-famous Paul Irish IE conditional comments HTML tag--in HAML.
  # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
  def cc_html(options={}, &blk)
    attrs = options.map { |(k, v)| " #{h k}='#{h v}'" }.join('')
    [ "<!--[if lt IE 7 ]> <html#{attrs} class='ie6'> <![endif]-->",
      "<!--[if IE 7 ]>    <html#{attrs} class='ie7'> <![endif]-->",
      "<!--[if IE 8 ]>    <html#{attrs} class='ie8'> <![endif]-->",
      "<!--[if IE 9 ]>    <html#{attrs} class='ie9'> <![endif]-->",
      "<!--[if (gt IE 9)|!(IE)]><!--> <html#{attrs}> <!--<![endif]-->",
      capture_haml(&blk).strip,
      "</html>"
    ].join("\n")
  end
end
