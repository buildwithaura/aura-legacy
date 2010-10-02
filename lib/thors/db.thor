class Db < Thor
  desc "flush", "Clear the database."
  def flush
    app

    tables = Aura::Models.all.map(&:table_name)
    tables &= DB.tables

    tables.each do |table|
      say_status :drop_table, table
      DB.drop_table table
    end
  end

protected
  def migrate(version)
    exec_cmd "sequel -m lib/migrations -M #{version} #{db}"
  end

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
