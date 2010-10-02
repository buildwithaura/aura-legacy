Sequel.migration do
  up do
    create_table :posts do
      primary_key :id
      foreign_key :parent_id, :posts

      String :template

      String :title
      String :body, :text => true
      String :slug
      String :author_name
    end
  end

  down do
    drop_table :posts
  end
end
