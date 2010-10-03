module Aura
  module Models
    class Post < Model
      plugin :aura_sluggable
      plugin :aura_renderable
      plugin :aura_editable

      many_to_one :parent, :class => self
      one_to_many :children, :key => :parent_id, :class => self

      editor_setup do
        field :text,     :title, "Title"
        field :textarea, :body,  "Body text", :class => 'long'
      end
    end
  end
end
