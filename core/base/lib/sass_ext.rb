module Sass
  module Script
    module Functions
      def ie_gradient_filter(start_color, end_color)
        assert_type start_color, :Color
        assert_type end_color, :Color
        s = "progid:DXImageTransform.Microsoft.gradient(startColorStr='#{start_color}', EndColorStr='#{end_color}')"
        Sass::Script::String.new s, :identifier
      end
    end
  end
end
