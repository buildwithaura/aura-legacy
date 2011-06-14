class Main
  get '/css/*.css' do |fname|
    content_type :css
    show :"css/#{fname}", :engine => [:sass, :scss, :less]
  end
end
