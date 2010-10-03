class Main
  get '/:model/list' do |model|
    @model = Aura::Models.get(model) or pass
    #pass unless @model.listable?

    show_admin @model.templates_for('list'), :model => @model
  end

  get '/:model/new' do |model|
    @model = Aura::Models.get(model) or pass
    pass unless @model.editable?

    @item = @model.new

    show_admin @model.templates_for('new'), :model => @model, :item => @item
  end

  post '/:model/save' do |model|
    @model = Aura::Models.get(model) or pass
    pass unless @model.editable?

    @item = @model.new
    @item.update params[:editor]
    @item.save

    redirect @item.class.path(:list)
  end

  get '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show_admin @item.templates_for('edit'), :item => @item
  end

  post '/*/save' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    @item.update params[:editor]
    @item.save

    redirect @item.class.path(:list)
  end

end
