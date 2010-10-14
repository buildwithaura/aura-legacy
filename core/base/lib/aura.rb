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
end
