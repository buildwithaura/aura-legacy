class Main
  get '/:model/list' do |model|
    @model = Aura::Models.get(model) or pass
    show @model.templates_for('list'), :model => @model
  end

  get '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show @item.templates_for('edit'), :item => @item
  end

end
