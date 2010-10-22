class Aura
  module Models
    class Page < Model
      set_schema do
        # aura_hierarchy
        primary_key :id
        foreign_key :parent_id, :pages

        String :title
        String :body, :text => true
        String :custom, :text => true

        # aura_sluggable
        String :slug

        # aura_subtyped
        String :subtype

        String :author_name #unused

        Time :created_at
        Time :modified_at
      end

      plugin :aura_sluggable      # Accessible via slug: /about-us/services
      plugin :aura_renderable     # Can show a page when accessed by that URL
      plugin :aura_editable       # Editable in the admin area
      plugin :aura_hierarchy      # Can have children
      plugin :aura_subtyped       # Has subtypes

      plugin :serialization, :yaml, :custom

      form do
        text :title, "Page title", :class => 'title main-title assert required'
        html :body,  "Body text", :class => 'long no-label'
        text :slug,  "Slug", :class => 'compact'

        fieldset(:meta, "Metadata") do
          text :meta_keywords, "Keywords", :class => 'compact-top'
          text :meta_description, "Description", :class => 'compact-bottom'
        end
      end

      def validate
        super
        validates_presence :title
      end

      # Returns the *other* form that depends on the subtype.
      def subform
        return nil  if subtype.nil?
        self.class.form subtype.id
      end

      # Creates a custom field and adds getters/setters for it.
      def self.custom_field(name)
        name = name.to_sym
        self.send(:define_method, name) do
          self.custom[name]  if self.custom.is_a? Hash
        end

        self.send(:define_method, :"#{name}=") do |v|
          self.custom ||= Hash.new
          self.custom[name] = v
        end
      end

      def meta_keywords=(v) v; end
      def meta_description=(v) v; end

      def self.content?; true; end
      def self.show_on_sidebar?; true; end
    end
  end
end
