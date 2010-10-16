Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      foreign_key :parent_id, :pages

      String :email
      String :slug
      String :crypted_password
      Time :last_login
    end
  end

  down do
    drop_table :users
  end
end

