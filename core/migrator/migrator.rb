module AutoMigrator
  def self.registered(app)
    app.extend ClassMethods
  end

  module ClassMethods
    def flush!(&blk)
      blk = lambda { |*a| }  unless block_given?

      tables = Aura::Models.all.map { |m| m.table_name }
      tables << :schema_info
      tables &= self.db.tables

      tables.each do |table|
        blk.call(:drop_table, table)
        self.db.drop_table table
      end
    end

    def seed!(type=nil, &blk)
      blk = lambda { |*a| }  unless block_given?

      Aura::Models.all.each { |m|
        blk.call :seed, m
        m.seed!(type, &blk)
      }
    end

    def auto_migrate!(&blk)
      blk = lambda { |*a| }  unless block_given?

      Sequel.extension :migration

      Aura::Extension.all.each do |ext|
        migrations_path = ext.path(:migrations)
        next  if migrations_path.nil?

        blk.call(:migrate, ext)

        Sequel::Migrator.run(self.db, migrations_path,
                             :table => :schema_info,
                             :column => :"#{ext}_version")
      end

      true
    end
  end
end

class Main
  register AutoMigrator
end
