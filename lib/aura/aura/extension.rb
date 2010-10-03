module Aura
  ExtensionNotFound = Class.new(StandardError)

  class Extension
    attr_reader :name

    def self.[](name)
      begin
        self.new(name)
      rescue ExtensionNotFound
        nil
      end
    end

    def initialize(name)
      if File.directory?(name)
        @path = name
        @name = File.basename(@path)
      else
        @name = name
        @path = root_path('extensions', name)
        raise ExtensionNotFound  unless File.directory?(@path)
      end
    end

    def path(*a)
      return @path  if a.empty?
      ret = File.join(@path, *(a.map(&:to_s)))
      File.exists?(ret) ? ret : nil
    end

    def load!
      # Load the main file
      fname = path("#{name}.rb")
      require fname  unless fname.nil?

      # Load the models
      Dir["#{@path}/models/*.rb"].each { |f| require f }

      # Ensure public/ works
      public_path = path(:public)
      Main.add_public(public_path)  unless public_path.nil?
    end

    alias to_s name
  end
end
