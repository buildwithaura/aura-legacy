class Db < Thor
  desc "migrate", "Ensures the DB schema is up to date."
  def migrate
    app.auto_migrate! self
  end
end
