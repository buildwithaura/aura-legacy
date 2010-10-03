module Aura
  def models(*a)
    Models.all(*a)
  end

  module_function :models

  def extensions
    Dir[root_path('extensions/*')].map { |path| Extension.new(path) }.sort
  end

  module_function :extensions

  Model = Sequel::Model
end
