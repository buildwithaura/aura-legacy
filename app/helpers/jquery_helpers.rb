class Main
  helpers do
    def jquery(path='/js/jquery.js', version='1.4.3')
      if settings.production?
        # Grab Google CDN's jQuery; fallback to local if necessary
        "<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js\"></script>"+
        "<script>!window.jQuery && document.write('<script src=\"#{path}\"><\\/script>')</script>"
      else
        "<script src='#{path}'></script>"
      end
    end
  end
end
