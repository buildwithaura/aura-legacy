module Sequel::Plugins::AuraHierarchy
  def self.configure(model)
    model.many_to_one :parent, :class => model
    model.one_to_many :children, :key => :parent_id, :class => model
  end

  module InstanceMethods
    def siblings
      if parent.nil?
        self.class.filter(:parent_id => nil)
      else
        parent.children
      end
    end

    def nearest
      children.any? ? children : siblings
    end

    def nearest_parent
      children.any? ? self : parent
    end
  end

  module ClassMethods
    def roots
      find_all(:parent_id => nil)
    end
  end
end
