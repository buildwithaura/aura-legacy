class Main
  get '/:model/list' do |model|
    @model = Aura::Models.get(model) or pass
    #pass unless @model.listable?

    show @model.templates_for('list'), :model => @model
  end

  get '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show @item.templates_for('edit'), :item => @item
  end

  post '/*/save' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    @item.update params[:editor]
    @item.save
    redirect @item.class.path(:list)
  end

end
