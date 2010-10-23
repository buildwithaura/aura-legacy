class Aura
  Model = Sequel::Model

  def self.get(key)
    Models::Setting.find(:key => key.to_s).try(:value)
  end

  def self.set(key, value)
    s = Models::Setting.find(:key => key.to_s) || Models::Setting.new
    s.key   = key
    s.value = value
    s.save
    value
  end

  def self.default(key, value)
    s = Models::Setting.find(:key => key.to_s)
    return set(key, value)  if s.nil?
    get key
  end

  def self.site_empty?
    ! Models.all.select { |m| m.content? }.detect { |m| m.any? }
  end

  # Returns the database backup as a hash.
  def self.db_dump
    db = Models.all.first.db

    Models.all.inject({}) { |hash, model|
      table = model.table_name
      hash[table] = db[table].all
      hash
    }
  end

  def self.db_restore(hash)
    # Hash format:
    # { :table_name => [ array of hashes of rows ], ... }

    # Bring the DB back to the state where we have tables ready.
    Main.flush!
    Models.all.each { |m| m.sync_schema }
    db = Models.all.first.db

    hash.each do |table, entries|
      entries.each do |entry|
        db[table] << entry
      end
    end
  end

  def self.db_dump_yaml
    require 'yaml'
    YAML::dump db_dump
  end
end
