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

      def self.seed(&blk)
        super

        require "ffaker"
        lorem = lambda { Faker::Lorem.paragraphs(3).map { |s| "<p>#{s}</p>" }.join("\n\n") }

        p1 = self.create :title => "Home",
                          :slug => "home",
                          :body => lorem.call

        p1 = self.create :title => "About us",
                          :slug => "about-us",
                          :body => lorem.call

        p1 = self.create :title => "Products",
                          :slug => "products",
                          :body => lorem.call

        p2 = self.create :title => "Applebottom Jeans",
                          :slug => "jeans",
                          :parent_id => p1.id,
                          :body => lorem.call

        p2 = self.create :title => "Boots with the fur",
                          :slug => "boots",
                          :parent_id => p1.id,
                          :body => lorem.call
      end
    end
  end
end
