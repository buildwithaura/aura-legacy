class Main
  set :view_formats, [ :erb, :haml, :erubis, :builder, :liquid, :mustache ]

  helpers do
    # Works like #render, except:
    #
    # - Tries many formats
    # - Tries many view paths
    # - Tries many templates
    # - Layouts doesn't have to be the same format as the view
    #
    # Examples:
    #
    #     show 'default', :item => @item
    #     show ['page/default', 'default']
    #     show 'default', { :item => @item }, { :layout => 'layout' }
    #     show 'css/chrome', {}, :view_formats => [ :sass, :less ]
    #
    def show(templates, params={}, options={}, &block)
      template, format = find_template(templates, options[:view_formats])
      return nil  if template.nil?

      layout = options[:layout]
      options.delete :layout

      ret = render(format, template, options, params)

      # Layout!
      if layout
        layout, layout_format = find_template(layout)
        return ret  if layout.nil?

        return render(layout_format, layout) { ret }
      end

      ret
    end

    def show_page(templates, params={})
      show templates, params, { :layout => 'layout' }
    end

    # Finds a template file.
    # Returns: a tuple of the template filename and the format.
    def find_template(templates, formats=nil)
      paths     = Aura::Extension.all.map { |m| m.path(:views) }.compact
      templates = [templates].flatten
      formats ||= settings.view_formats

      templates.each do |template|
        paths.each do |path|
          formats.each do |format|
            tpl = template_for(template, format, path) or next
            return [tpl, format]
          end
        end
      end

      nil #Fail
    end

    def partial(templates, params={})
      show(templates, params, {:layout => false})
    end

    def template_for(template, format, path)
      fname = File.join(path, "#{template}.#{format}")
      return nil  unless File.exists?(fname)

      File.open(fname) { |f| f.read }
    end

    def h(str)
      Rack::Utils.escape_html(str)
    end
  end
end

