class Aura
  module Models
    class Page < Model
      plugin :aura_sluggable      # Accessible via slug: /about-us/services
      plugin :aura_renderable     # Can show a page when accessed by that URL
      plugin :aura_editable       # Editable in the admin area
      plugin :aura_hierarchy      # Can have children
      plugin :aura_subtyped       # Has subtypes

      plugin :serialization, :json, :custom

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
