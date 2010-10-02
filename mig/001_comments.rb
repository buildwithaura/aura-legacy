Sequel.migration do
  up do
    create_table :comments do
      String :subject
      String :body, :text => true
    end
  end
end
