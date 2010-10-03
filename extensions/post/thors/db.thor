class Db
  alias _post_seed _seed

protected
  def _seed
   _post_seed

    posts = Aura::Models::Post
    posts.delete
    say_status :seed, posts

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
