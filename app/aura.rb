module Aura
  module Models
    def all
      constants.map { |cons| const_get(cons) }
    end

    module_function :all
  end

  Model = Sequel::Model

  module Admin
    extend self

    def <<(key)
    end
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
