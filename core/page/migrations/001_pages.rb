Sequel.migration do
  up do
    create_table :pages do
      # aura_hierarchy
      primary_key :id
      foreign_key :parent_id, :pages

      String :title
      String :body, :text => true
      String :custom, :text => true

      # aura_sluggable
      String :slug

      # aura_subtyped
      String :subtype

      String :author_name #unused
    end
  end

  down do
    drop_table :pages
  end
end
