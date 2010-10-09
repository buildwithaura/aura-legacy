class Db < Thor
  include Aura::ThorActions

  desc "seed", "Seed data"
  def seed
    app
    _seed
  end

protected
  def _seed
  end
end
