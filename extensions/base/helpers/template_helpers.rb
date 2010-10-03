class Main
  set :view_formats, [ :erb, :haml ]

  helpers do
    # Works like #render, except:
    #
    # - Tries many formats
    # - Tries many view paths
    # - Tries many templates
    #
    def show(templates, params={}, options={})
      paths     = Aura.extensions.map { |m| m.path(:views) }.compact # TODO: Should use settings.view_paths
      paths.unshift nil

      templates = [templates].flatten

      templates.each do |template|
        paths.each do |path|
          settings.view_formats.each do |format|
            tpl = template_for(template, format, path) or next
            return render(format, tpl, options, params)
          end
        end
      end

      nil #Fail
    end

    def partial(templates, params={})
      show(templates, params, {})
    end

    def template_for(template, format, path)
      if path.nil?
        fname = File.join(self.class.views, "#{template}.#{format}")
        return nil  unless File.exists?(fname)

        template.to_sym

      else
        fname = File.join(path, "#{template}.#{format}")
        return nil  unless File.exists?(fname)

        File.open(fname) { |f| f.read }
      end
    end

    def h(str)
      Rack::Utils.escape_html(str)
    end
  end
end

