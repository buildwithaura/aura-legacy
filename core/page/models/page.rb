class Aura
  module Models
    class Page < Model
      plugin :aura_sluggable
      plugin :aura_renderable
      plugin :aura_editable
      plugin :aura_hierarchy

      form {
        field :text,     :title, "Title"
        field :textarea, :body,  "Body text", :class => 'long'
        field :text,     :slug,  "Slug"

        fieldset(:meta, "Metadata") {
          field :text, :meta_keywords, "Keywords"
          field :text, :meta_description, "Description"
        }
      }

      def validate
        super
        validates_presence :title
      end

      def meta_keywords=(v) v; end
      def meta_description=(v) v; end

      def self.content?; true; end
      def self.show_on_sidebar?; true; end
    end
  end
end
