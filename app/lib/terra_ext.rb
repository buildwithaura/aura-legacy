module Terra
  module Fields
    class Html < Textarea
      def html_wrap(s)
        "<p class='html #{options[:class] || ''}'>#{s}</p>"
      end
    end
  end
end
