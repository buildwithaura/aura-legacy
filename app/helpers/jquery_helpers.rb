class Main
  module JqueryHelpers
    def jquery(path='/js/jquery.js', version='1.4.3')
      if settings.production?
        # Grab Google CDN's jQuery; fallback to local if necessary
        url = "http://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js"
        "<script src=\"#{url}\"></script>"+
        "<script>!window.jQuery && document.write('<script src=\"#{path}\"><\\/script>')</script>"
      else
        "<script type='text/javascript' src='#{path}'></script>"
      end
    end

    def jquery_ui(path='/js/jqueryui.js', version='1.8.5')
      if settings.production?
        url = "https://ajax.googleapis.com/ajax/libs/jqueryui/#{version}/jquery-ui.min.js"
        "<script src=\"#{url}\"></script>"+
        "<script>!window.jQuery.ui && document.write('<script src=\"#{path}\"><\\/script>')</script>"
      else
        "<script type='text/javascript' src='#{path}'></script>"
      end
    end
  end

  helpers JqueryHelpers
end
