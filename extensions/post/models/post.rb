module Aura
  module Models
    class Post < Model
      plugin :aura_sluggable
      plugin :aura_renderable

      many_to_one :parent, :class => self
      one_to_many :children, :key => :parent_id, :class => self
    end
  end
end
