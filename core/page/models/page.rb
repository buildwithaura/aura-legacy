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

        [ "Sony iPhone", "Blackberry iXUS",
          "Canon Vostro", "Nokia Curve"
        ].each do |product|
          p2 = self.create :title => product,
                            :parent_id => p1.id,
                            :body => lorem.call
          [ "8GB Black", "8GB White", "16GB 3G", "16GB Wifi" ].each do |type|
            p3 = self.create :title => type,
                              :parent_id => p2.id,
                              :body => lorem.call
          end
        end

        p1 = self.create :title => "Employees",
                          :slug => "employees",
                          :body => lorem.call

        8.times {
          p2 = self.create :title => Faker::Name.name,
                            :parent_id => p1.id,
                            :body => lorem.call
        }
      end
    end
  end
end
