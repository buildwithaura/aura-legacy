class Aura
  module Editor
    module Fields
      def get(klass)
        begin
          const_get(klass.to_s.split('_').map { |s| s.capitalize }.join('').to_sym)
        rescue NameError
          nil
        end
      end
      module_function :get
    end
  end
end

class Aura
  module Editor
    module Fields
      class Text < Field
      end

      class Textarea < Field
        def input_html(val)
          "<textarea type='text' name='#{input_name}'>#{h val}</textarea>"
        end
      end
    end
  end
end
