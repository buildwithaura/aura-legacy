module AutoMigrator
  def self.registered(app)
    app.extend ClassMethods
  end

  module ClassMethods
    def auto_migrate!(status=nil)
      Sequel.extension :migration

      Aura::Extension.all.each do |ext|
        migrations_path = ext.path(:migrations)
        next  if migrations_path.nil?

        status.say_status(:migrate, ext)  if status.respond_to?(:say_status)

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
