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
        @path, @name = name, File.basename(name)
      else
        @name, @path = name, root_path('extensions', name)
      end

      raise ExtensionNotFound  unless File.directory?(@path)
    end

    def path(*a)
      return @path  if a.empty?
      ret = File.join(@path, *(a.map(&:to_s)))
      File.exists?(ret) ? ret : nil
    end

    def load!
      # TODO: Don't load a module that's already loaded

      # Load the main file
      fname = path("#{name}.rb")
      require fname  unless fname.nil?

      # Load the basic things usually autoloaded.
      Dir["#{@path}/{models,routes,helpers}/*.rb"].each { |f| require f }

      # Ensure public/ works
      public_path = path(:public)
      Main.add_public(public_path)  unless public_path.nil?

      # Add the view path, if it has
      if path(:views)
        paths = [path(:views)]
        paths += Main.view_paths  if Main.respond_to?(:view_paths)
        Main.set :view_paths, paths
      end
    end

    def <=>(other)
      self.sort_position <=> other.sort_position
    end

    def sort_position
      to_s
    end

    alias to_s name

    def self.all
      Dir[Main.root_path('{core,extensions}/{base,*}')].uniq.map { |path| self.new(path) }
    end
  end
end
