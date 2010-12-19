class Main
  get '/css/*.css' do |fname|
    content_type :css
    css fname
  end
end
