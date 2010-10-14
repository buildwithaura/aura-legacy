Sequel.migration do
  up do
    create_table :settings do
      primary_key :id

      String :key
      String :value, :text => true
      index :key
    end
  end

  down do
    drop_table :settings
  end
end

