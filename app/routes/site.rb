class Main
  get '/*' do |path|
    @page = Aura::Slugs.find(path) or pass
    show [@page.template, :default], :page => @page
  end

  get '/post/:id' do |id|
    post = Aura::Models::Post[id.to_i]
    post.inspect
  end

  get '/' do
    "Welcome!"
  end

  get '/aoeu' do
    ":)"
  end
end
