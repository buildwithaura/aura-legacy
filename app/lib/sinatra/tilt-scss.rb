module Tilt
  class ScssTemplate < SassTemplate # @private
  private
    def sass_options
      super.merge(:syntax => :scss)
    end
  end
  register 'scss', ScssTemplate  unless Tilt::VERSION.to_f > 0.8
end
