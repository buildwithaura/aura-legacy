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

    # Returns a set of results of all records that don't have parents.
    def roots
      find_all { |*a| true }
    end

    # Ensures that the model has some bare essentials in it.
    #
    # This is called every time the application initializes.
    # Override this if you need certain records to exist, like as
    # how there is always one user.
    #
    # As this is called every application load, if you override this,
    # it is your responsibility to check if the model is #empty? before
    # writing anything.
    #
    # A parameter `type` may be given. If this is set to `:sample`, then
    # load up some sample data.
    #
    def seed(type=nil, &b)
      sync_schema  unless schema.nil?
    end

    # Like `seed`, but empties the table first.
    def seed!(type=nil, &b)
      sync_schema  unless schema.nil?
      delete
      seed type, &b
    end

    # Determines if the model can have children.
    # Reimplemented by aura_hierarchy.
    def parentable?
      false
    end

    def templates_for(template)
      [ :"#{class_name}/#{template}",
        :"base/#{template}"
      ]
    end

    # Returns a string of the model's name for use in URLs.
    #
    # Example:
    #   BlogPost.class_name #=> "blog_post"
    #
    def class_name
      self.to_s.demodulize.underscore
    end

    # Returns a string of the model's name to appear on pages.
    #
    #   BlogPost.title #=> "Blog post"
    #
    def title
      self.class_name.humanize
    end

    # Returns a string of the model's name, pluralized, to appear on pages.
    #
    # Example:
    #   BlogPost.title_plural #=> "Blog posts"
    #
    def title_plural
      self.title.pluralize
    end

    # Retruns a URL path for an action for the model.
    #
    # Example:
    #   BlogPost.path               #=> /blog_post
    #   BlogPost.path(:list)        #=> /blog_post/list
    #   BlogPost.path(:list, :all)  #=> /blog_post/list/all
    #
    def path(*a)
      ret = "/#{class_name}"
      ret += "/#{a.shift}"  if a.first.is_a?(String) || a.first.is_a?(Symbol)
      ret += "?" + Aura::Utils.query_string(a.shift)  if a.first.is_a?(Hash)
      ret
    end

  end
end
