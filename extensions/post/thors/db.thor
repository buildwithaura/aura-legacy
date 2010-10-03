class Db
  alias _post_seed _seed

protected
  def _seed
    _post_seed

    require "ffaker"
    posts = Aura::Models::Post
    posts.delete
    say_status :seed, posts

    p1 = posts.create :title => "About us",
                      :slug => "about-us",
                      :body => lorem

    p1 = posts.create :title => "Products",
                      :slug => "products",
                      :body => lorem

    p2 = posts.create :title => "Applebottom Jeans",
                      :slug => "jeans",
                      :parent_id => p1.id,
                      :body => lorem

    p2 = posts.create :title => "Boots with the fur",
                      :slug => "boots",
                      :parent_id => p1.id,
                      :body => lorem
  end

  def lorem
    Faker::Lorem.paragraphs(3).map { |s| "<p>#{s}</p>" }.join("\n\n")
  end
end
