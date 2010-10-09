class Main
  get '/css/:fname.css' do |fname|
    # TODO: Caching
    content_type :css
    css fname
  end
end
