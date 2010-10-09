class Main
  helpers do
    def load_path(path)
      @item = Aura::Slugs.find(path) or pass
      pass  unless @item.try(:renderable?)

      show @item.page_templates, {}, :item => @item
    end
  end

  get '/*' do |path|
    load_path path
  end

  get '/' do
    load_path('/home')
  end

  not_found do
    error 404, show('errors/not_found')
  end

  error 500 do
    error 500, show('errors/error')
  end
end

