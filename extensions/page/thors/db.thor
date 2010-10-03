class Db
  alias _page_seed _seed

protected
  def _seed
    _page_seed

    require "ffaker"
    pages = Aura::Models::Page
    pages.delete
    say_status :seed, pages

    p1 = pages.create :title => "About us",
                      :slug => "about-us",
                      :body => lorem

    p1 = pages.create :title => "Products",
                      :slug => "products",
                      :body => lorem

    p2 = pages.create :title => "Applebottom Jeans",
                      :slug => "jeans",
                      :parent_id => p1.id,
                      :body => lorem

    p2 = pages.create :title => "Boots with the fur",
                      :slug => "boots",
                      :parent_id => p1.id,
                      :body => lorem
  end

  def lorem
    Faker::Lorem.paragraphs(3).map { |s| "<p>#{s}</p>" }.join("\n\n")
  end
end
