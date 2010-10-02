class Post < Thor
  include Aura::ThorActions

  desc "seed", "Seed data"
  def seed
    app

    post = Aura::Models::Post

    post.create :title => "About us",
                :slug => "about-us",
                :body => "Hello there."

    p = post.create :title => "Products",
                    :slug => "products"

    post.create :title => "Applebottom Jeans",
                :slug => "jeans",
                :parent_id => p.id

    post.create :title => "Boots with the fur",
                :slug => "boots",
                :parent_id => p.id
  end
end
