module Sequel::Plugins::AuraModel
  def self.configure(model)
    model.plugin :validation_helpers
  end

  module InstanceMethods
    def to_s
      begin
        title
      rescue NoMethodError
        @values[:title] || self.class.to_s.split('::').last
      end
    end

    def templates_for(template)
      self.class.templates_for template
    end

    def path(*a)
      ret = "/#{self.class.class_name}/#{self.id}"
      ret += "/#{a.shift.to_s}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
      ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
      ret
    end

    # Reimplemented by aura_hierarchy
    def parentable?
      false
    end

    def parent
      nil
    end

    def parent?
      ! parent.nil?
    end

    def children
      Array.new
    end

    def crumbs
      [self]
    end

    def depth
      crumbs.size
    end

    def is_parent_of?(target)
      target.crumbs.include?(self)
    end
  end

  module ClassMethods
    # Returns if the model data is considered to be site content.
    # The site is considered empty if all models that are content?
    # are empty.
    def content?
      false
    end

    def roots
      find_all { |*a| true }
    end

    def seed!(type=nil, &b)
      delete
      seed type, &b
    end

    def seed(type=nil, &b)
    end

    # Reimplemented by aura_hierarchy
    def parentable?
      false
    end

    def templates_for(template)
      [ :"#{class_name}/#{template}",
        :"base/#{template}"
      ]
    end

    # "BlogPost" => "blog_post"
    # Used for URLs.
    def class_name
      self.to_s.demodulize.underscore
    end

    # "BlogPost" => "Blog post"
    # Used for display.
    def title
      self.class_name.humanize
    end

    # "BlogPost" => "Blog posts"
    # Used for display.
    def title_plural
      self.title.pluralize
    end

    def path(*a)
      ret = "/#{class_name}"
      ret += "/#{a.shift}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
      ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
      ret
    end

  end
end
