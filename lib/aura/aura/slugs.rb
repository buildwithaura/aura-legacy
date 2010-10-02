module Aura
  module Slugs
    extend self

    def find(path)
      path = path.split('/').reject(&:empty?)
      item = nil

      path.each do |slug|
        item = find_single(slug, item)
        return nil  if item.nil?
      end

      item
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
      @models << model
    end

    def models
      @models ||= []
    end
  end
end

