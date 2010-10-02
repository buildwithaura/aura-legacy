Sequel.migration do
  up do
    create_table :posts do
      String :title
      String :body, :text => true
      String :author_name
    end
  end

  down do
    drop_table :posts
  end
end
