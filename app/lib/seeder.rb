module Seeder
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

    def seed(type=nil, &blk)
      blk = lambda { |*a| }  unless block_given?

      Aura::Models.all.each { |m|
        blk.call :seed, m.title_plural
        m.seed(type, &blk)
      }
    end

    def seed!(type=nil, &blk)
      blk = lambda { |*a| }  unless block_given?

      Aura::Models.all.each { |m|
        blk.call :seed, m.title_plural
        m.seed!(type, &blk)
      }
    end
  end
end
