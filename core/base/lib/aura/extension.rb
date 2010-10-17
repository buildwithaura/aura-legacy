class Aura
  ExtensionNotFound = Class.new(StandardError)

  class Extension
    attr_reader :name

    # Returns an extension with the given ext name/path.
    # Returns nil if it's not found.
    def self.[](name)
      begin
        self.new(name)
      rescue ExtensionNotFound
        nil
      end
    end

    # Returns an extension with the given ext name/path.
    # Raises ExtensionNotFound if it's not found.
    def initialize(name)
      @path, @name = nil

      if File.directory?(name)
        @path, @name = name, File.basename(name)
      elsif Main.respond_to?(:extensions_path)
        @name = name
        [Main.extensions_path].flatten.each do |dir|
          next  unless @path.nil?
          @path = File.join(dir, name)
          @path = nil  unless File.directory?(@path)
        end
      end

      raise ExtensionNotFound  unless File.directory?(@path)
    end

    def path(*a)
      return @path  if a.empty?
      ret = File.join(@path, *(a.map { |arg| arg.to_s }))
      ret = File.expand_path(ret) # Try to fix some heroku issues (?)
      File.exists?(ret) ? ret : nil
    end

    # Loads an extension.
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

    # Initializes an extension after it's already loaded.
    # This is done after all extensions are loaded.
    def init
      fname = path("init.rb")
      load fname  unless fname.nil?
    end

    def info
      return @info  unless @info.nil?

      fname = path('info.yml')
      return nil  if fname.nil?

      require 'yaml'
      require 'ostruct'
      @info ||= OpenStruct.new(YAML::load_file(fname).merge({:path => @path}))
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
