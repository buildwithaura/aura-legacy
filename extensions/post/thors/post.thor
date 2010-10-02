class Post < Thor
  include Aura::ThorActions

  desc "seed", "Seed data"
  def seed
    app

    posts = Aura::Models::Post

    posts.delete

    p1 = posts.create :title => "About us",
                      :slug => "about-us",
                      :body => "Hello there."

    p1 = posts.create :title => "Products",
                      :slug => "products"

    p2 = posts.create :title => "Applebottom Jeans",
                      :slug => "jeans",
                      :parent_id => p1.id

    p2 = posts.create :title => "Boots with the fur",
                      :slug => "boots",
                      :parent_id => p1.id
  end
end
