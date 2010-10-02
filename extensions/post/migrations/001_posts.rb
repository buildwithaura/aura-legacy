Sequel.migration do
  up do
    create_table :posts do
      String :title
      String :body, :text => true
      String :author_name
    end
  end
end
