module Aura
  module Models
    def all
      constants.map { |cons| const_get(cons) }
    end

    module_function :all
  end
end

#==============================================================================

module Aura
  def models(*a)
    Models.all(*a)
  end

  module_function :models

  def extensions
    Dir[root_path('extensions/*')].map { |path| Extension.new(path) }
  end

  module_function :extensions

  Model = Sequel::Model
end

#==============================================================================

module Aura
  module Admin
    extend self

    def <<(key)
    end
  end
end

#==============================================================================

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

    alias to_s name
  end
end

class Main
  helpers do
    def passthru(fname)
      File.open(fname) { |f| f.read }
    end
  end

  def self.add_public(dir)
    Dir[File.join(dir, '**/*')].each do |fname|
      path = fname.gsub(/^#{dir}\/*/, '/')
      get(path) { passthru(fname) }
    end
  end
end
