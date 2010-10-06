class Main
  helpers do
    def show_admin(template, params={})
      show template, params, :layout => 'admin/layout'
    end

    def admin_assets(type, file=nil, priority=5)
      @admin_assets ||= Hash.new { |h, k| h[k] = Array.new }
      @admin_assets[type][priority] ||= Array.new
      @admin_assets[type][priority] << file  unless file.nil?
      @admin_assets[type].flatten.compact
    end

    def admin_js(file=nil, priority=5)
      admin_assets(:js, file, priority)
    end

    def admin_css(file=nil, priority=5)
      admin_assets(:css, file, priority)
    end
  end
end