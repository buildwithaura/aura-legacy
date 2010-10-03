class Main
  helpers do
    def show_admin(template, params={})
      show template, params, :layout => 'admin/layout'
    end
  end
end
