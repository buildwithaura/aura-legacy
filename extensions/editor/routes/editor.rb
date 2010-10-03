class Main
  get '/:model/list' do |model|
    @model = Aura::Models.get(model) or pass
    #pass unless @model.listable?

    show_admin @model.templates_for('list'),
      :model => @model
  end

  get '/:model/new' do |model|
    @model = Aura::Models.get(model) or pass
    pass unless @model.editable?

    @item = @model.new

    show_admin @model.templates_for('new'),
      :model  => @model,
      :item   => @item,
      :action => @model.path(:new)
  end

  post '/:model/new' do |model|
    @model = Aura::Models.get(model) or pass
    pass unless @model.editable?

    begin
      @item = @model.new
      @item.update params[:editor]
      @item.save

    rescue Sequel::ValidationFailed
      return show_admin @model.templates_for('new'),
        :model  => @model,
        :item   => @item,
        :action => @model.path(:new)
    end

    redirect @item.class.path(:list)
  end

  get '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show_admin @item.templates_for('edit'),
      :item   => @item,
      :action => @item.path(:edit)
  end

  post '/*/edit' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    action = @item.path(:edit)

    begin
      @item.update params[:editor]
      @item.save

    rescue Sequel::ValidationFailed
      return show_admin @item.templates_for('edit'),
        :item   => @item,
        :action => action
    end

    redirect @item.class.path(:list)
  end

  get '/*/delete' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    show_admin @item.templates_for('delete'),
      :item   => @item,
      :action => @item.path(:delete)
  end

  post '/*/delete' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    action = @item.class.path(:list)
    @item.delete

    redirect action
  end

end
