class Main
  helpers do
    def css(fname)
      content_type :css
      options = { :layout => false, :view_formats => [ :less, :sass, :scss ] }
      show "css/#{fname}", options
    end
  end

  get '/css/:fname.css' do |fname|
    # TODO: Caching
    css fname
  end
end
