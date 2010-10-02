module Aura
  module Public
    def self.registered(app)
      app.helpers Helpers
      app.extend ClassMethods
    end

    module ClassMethods
      def add_public(dir)
        Dir[File.join(dir, '**/*')].each do |fname|
          path = fname.gsub(/^#{dir}\/*/, '/')
          get(path) { passthru(fname) }
        end
      end
    end

    module Helpers
      def passthru(fname)
        File.open(fname) { |f| f.read }
      end
    end
  end
end
