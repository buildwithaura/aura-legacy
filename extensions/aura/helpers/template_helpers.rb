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
      template, format = find_template(templates, options[:view_formats])
      return nil  if template.nil?

      render format, template, options, params
    end

    # Finds a template file.
    # Returns: a tuple of the template filename and the format.
    def find_template(templates, formats)
      paths     = Aura.extensions.map { |m| m.path(:views) }.compact # TODO: Should use settings.view_paths

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
      show(templates, params, {})
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

