class Main
  get '/*' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass  unless @item.renderable?

    show_page @item.page_templates, :item => @item
  end

  get '/' do
    "Welcome!"
  end
end

