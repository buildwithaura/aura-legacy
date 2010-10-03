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
      :action => @model.path(:new),
      :errors => []
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
      :action => @item.path(:save),
      :errors => []
  end

  post '/*/save' do |path|
    @item = Aura::Slugs.find(path) or pass
    pass unless @item.editable?

    action = @item.path(:save)

    begin
      @item.update params[:editor]
      @item.save

    rescue Sequel::ValidationFailed
      return show_admin @item.templates_for('edit'),
        :item   => @item,
        :action => action,
        :errors => @item.errors
    end

    redirect @item.class.path(:list)
  end

end
