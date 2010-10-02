class Db < Thor
  desc "flush", "Clear the database."
  def flush
    app

    tables = Aura.models.map(&:table_name)
    tables << :schema_info
    tables &= db.tables

    tables.each do |table|
      say_status :drop_table, table
      db.drop_table table
    end
  end

  desc "migrate", "Ensures the DB schema is up to date."
  def migrate
    app
    Sequel.extension :migration

    Aura.extensions.each do |ext|
      migrations_path = ext.path(:migrations)
      next  if migrations_path.nil?

      say_status :migrate, ext
      Sequel::Migrator.run(db, migrations_path,
                           :table => :schema_info,
                           :column => :"#{ext}_version")
    end
  end

protected
  def app
    require './init'; Main
  end

  def db_path
    app; app_config(:sequel, :db)
  end

  def db
    app; DB
  end

  def env
    ENV['RACK_ENV'] || 'development'
  end

  def exec_cmd(cmd)
    say_status :run, cmd
  end
end
