class Aura
  module Models
    class Page < Model
      plugin :aura_sluggable
      plugin :aura_renderable
      plugin :aura_editable
      plugin :aura_hierarchy

      form {
        text     :title, "Title", :class => 'title'
        textarea :body,  "Body text", :class => 'long'
        text     :slug,  "Slug", :class => 'compact'

        fieldset(:meta, "Metadata") {
          text :meta_keywords, "Keywords", :class => 'compact'
          text :meta_description, "Description", :class => 'compact'
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
