class Main
  get '/*/responses' do |path|
    require_login

    @item = Aura.find(path) or pass
    pass unless @item.is_a?(ContactForm)

    show_admin @item.templates_for('responses'),
      :item   => @item
  end
end
