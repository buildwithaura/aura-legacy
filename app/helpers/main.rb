class Main
  set :view_formats, [ :erb, :haml ]

  helpers do
    # Works like #render, except:
    #
    # - Tries many formats
    # - Tries many view paths
    # - Tries many templates
    #
    def show(templates, params={})
      paths     = Aura.extensions.map { |m| m.path(:views) }.compact
      paths.unshift nil

      templates = [templates].flatten

      templates.each do |template|
        paths.each do |path|
          settings.view_formats.each do |format|
            tpl = template_for(template, format, path) or next
            return render(format, tpl, {}, params)
          end
        end
      end

      nil #Fail
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
  end
end
