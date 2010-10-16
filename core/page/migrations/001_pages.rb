Sequel.migration do
  up do
    create_table :pages do
      primary_key :id
      foreign_key :parent_id, :pages

      String :template

      String :title
      String :body, :text => true
      String :slug
      String :author_name #unused
      String :subtype
    end
  end

  down do
    drop_table :pages
  end
end
