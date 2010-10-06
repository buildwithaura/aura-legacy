module Aura
  module Models
    class Page < Model
      plugin :aura_sluggable
      plugin :aura_renderable
      plugin :aura_editable
      plugin :aura_hierarchy

      editor_setup do
        field :text,     :title, "Title"
        field :textarea, :body,  "Body text", :class => 'long'
        field :text,     :slug,  "Slug"
      end

      def validate
        super
        validates_presence :title
      end
    end
  end
end
