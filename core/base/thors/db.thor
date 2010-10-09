class Db < Thor
  include Aura::ThorActions

  desc "flush", "Clear the database."
  def flush
    app

    tables = Aura::Models.all.map(&:table_name)
    tables << :schema_info
    tables &= app.db.tables

    tables.each do |table|
      say_status :drop_table, table
      app.db.drop_table table
    end
  end

  desc "seed", "Seed data"
  def seed
    app
    _seed
  end

protected
  def _seed
  end
end
