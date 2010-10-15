class Main
  get '/css/:fname.css' do |fname|
    content_type :css
    css fname
  end
end
