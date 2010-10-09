module Aura
  module Slugs # TODO: Change to Router
    extend self

    # Finds a model from a path.
    #
    # Example:
    #   find('/products/boots')
    #
    def find(path)
      item = find_by_model_id(path)
      return item  unless item.nil?

      path = path.split('/').reject { |s| s.empty? }
      item = nil

      path.each do |slug|
        item = find_single(slug, item)
        return nil  if item.nil?
      end

      item
    end

    def find_by_model_id(path)
      model_name, id = path.squeeze('/').split('/').compact
      return nil  if id.nil?

      # Make sure it's numeric
      id = id.to_i
      return nil  if id == 0

      model = Aura::Models.all.detect { |m| m.class_name == model_name }
      return nil  if model.nil?

      model[id]
    end

    def find_single(slug, parent=nil)
      models.each do |model|
        item = model.get_by_slug(slug, parent)
        return item  unless item.nil?
      end
      nil
    end

    def register(model)
      @models ||= []
      @models << model  unless @models.include? model
    end

    def models
      @models ||= []
    end
  end
end

