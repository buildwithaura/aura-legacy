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
end

