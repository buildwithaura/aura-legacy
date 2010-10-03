class Main
  helpers do
    # Works like #render, except:
    #
    # - Tries many formats
    # - Tries many view paths
    # - Tries many templates
    #
    def show(templates, params={})
      template_paths = Aura.extensions.map { |m| m.path(:views) }.compact

      templates = [templates].flatten # to_a
      templates.each do |template|
        ([nil] + template_paths).each do |path|
          [ :erb, :haml ].each do |format|
            begin
              if path.nil?
                template = template.to_sym
              else
                fname = File.join(path, "#{template}.#{format}")
                next  unless File.exists?(fname)
                template = File.open(fname) { |f| f.read }
              end

              # TODO: Cache this hit
              return render(format, template, {}, params)
            rescue Errno::ENOENT
            end
          end
        end
      end
      nil
    end
  end
end
