class Main
  helpers do
    def show_admin(template, locals={})
      show template, { :layout => :'admin/layout' }, locals
    end

    def area_class(str=nil)
      @area_class = str  unless str.nil?
      @area_class
    end

    def admin_css
      [{ :href => '/css/admin.css', :media => 'screen' }]
    end

    def admin_icon(icon)
      icon = "#{icon}.png"  unless icon.to_s.include?('.')
      tag(:img, nil, { :src => "/images/admin_icons/#{icon}", :class => 'icon' })
    end
  end
end
