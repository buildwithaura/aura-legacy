class Main
  get '/css/:fname.css' do |fname|
    content_type :css
    # TODO: Caching
    show "css/#{fname}", {}, :view_formats => [ :less, :sass, :scss ]
  end
end
