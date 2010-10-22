# Makes Sinatra support multiple view paths, among other niceties.
# Usage:
#
#     class Main < Sinatra::Base
#       register Sinatra::MultiView
#
#       get '/' do
#         locals = { :name => current_user.name }
#
#         # Instead of `haml 'home', {}, locals`
#         show 'home', {}, locals
#       end
#
#       # Optional: look in many paths
#       set :view_paths, [ './views/', './theme/views/' ]
#
#       # Optional: restrict searching to these formats
#       set :view_formats, [ :erb, :haml ]
#
#       # Optional: Default options for anything using show()
#       set :view_options, { :layout => true }
#     end
#
module Sinatra::MultiView
  def self.registered(app)
    unless app.respond_to?(:view_formats)
      app.set :view_formats, [ :erb, :haml, :erubis, :builder, :liquid, :mustache ]
    end

    app.helpers Helpers
  end

  module Helpers
    # Works like haml() (or any other template helper), except:
    #
    # - Tries many engines
    # - Tries many view paths, as set in your app's :view_paths
    # - Tries many templates, if you pass it an array
    # - Layouts don't have to use the same engine as the view
    # - In addition to `settings.haml`, it also checks settings.view_options
    # - Can't pass data onto it (doesn't make sense!), the `template` parameter
    #   is always assumed to be a template name
    # - Layouts can be defined by the view files (using #layout)
    #
    # Examples:
    #
    #     show 'default', {}, :item => @item
    #     show ['page/default', 'default']
    #     show 'default', { :layout => 'layout' }, { :item => @item }
    #     show 'css/chrome', { :view_formats => [ :sass, :less ], :layout => false }
    #
    def show(templates, options={}, locals={}, &block)
      # Merge app-level options.
      options = settings.view_options.merge(options) if settings.respond_to?(:view_options)

      # Find the template file (try many paths and formats)
      path, template, format = find_template(templates, options[:view_formats])
      return nil  if template.nil?

      @layout = false
      ret = _render(format, template, options.merge({ :views => path }), locals)

      # The default Sinatra layouting assumes that the layout will be the
      # same format as the actual page. Let's fix it so that the layout
      # can be anything else.
      layout = @layout || options[:layout]
      if layout
        layout_path, layout, layout_format = find_template(layout)
        return ret  if layout.nil?

        return _render(layout_format, layout, { :views => layout_path }) { ret }
      end

      @layout = false
      ret
    end

    # Renders a template with a given absolute path.
    # (Sinatra's render() doesn't support abs paths)
    def _render(format, fname, options={}, locals={}, &blk)
      overrides = Hash.new
      overrides[:layout] = false
      render(format, fname.to_sym, options.merge(overrides), locals, &blk)
    end

    # Lets the layout for the view.
    # This overrides whatever layout is passed onto show().
    # 
    # Example:
    #
    #     <!-- views/page.erb -->
    #     <% layout 'template' %>
    #
    def layout(given_layout=nil)
      @layout = given_layout  unless given_layout.nil?
      @layout
    end

    def partial(templates, locals={}, options={})
      show(templates, {:layout => false}.merge(options), locals)
    end

    def css(fname)
      options = { :layout => false, :view_formats => [ :less, :sass, :scss ] }
      show "css/#{fname}", options
    end

    def find_template(templates, formats=nil)
      paths       = settings.view_paths  if settings.respond_to?(:view_paths)
      paths     ||= settings.views || './views'
      templates   = [templates].flatten
      formats   ||= settings.view_formats

      hash = "@#{templates}@#{formats}"
      @view_cache ||= Hash.new
      return @view_cache[hash]  if @view_cache.keys.include?(hash)

      @view_cache[hash] = _find_template(templates, paths, formats)
    end

  protected

    # Finds a template file.
    # Returns: a 3-item tuple of the template path, filename and the format.
    def _find_template(templates, paths, formats)
      templates.each do |template|
        paths.each do |path|
          formats.each do |format|
            tpl = template_for(template, format, path) or next
            return [path, template, format]
          end
        end
      end

      nil #Fail
    end

    # Returns the filename of a given template path and format.
    #
    # Example:
    #
    #     template_for('app/views/layout', 'haml')
    #
    def template_for(template, format, path)
      fname = File.join(path.to_s, "#{template}.#{format}")
      return nil  unless File.exists?(fname)

      fname
    end
  end
end

