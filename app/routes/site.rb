class Main
  get '/*' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass  unless @item.renderable?

    show @item.page_templates, :item => @item
  end

  get '/:model/list' do |model|
    @model = Aura::Models.get(model) or pass
    show @model.templates_for('list'), :model => @model
  end

  get '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show @item.templates_for('edit'), :item => @item
  end

  get '/' do
    "Welcome!"
  end

  get '/aoeu' do
    ":)"
  end
end
