module Tilt
  class ScssTemplate < SassTemplate
  private
    def sass_options
      h = super
      h = h.merge(:syntax => :scss)
      h = h.merge(:line_numbers => true, :debug_info => true, :always_check => true)  if Main.development?
      h
    end
  end
  register 'scss', ScssTemplate  unless Tilt::VERSION.to_f > 0.8
end
