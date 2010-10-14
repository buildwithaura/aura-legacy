class Aura
  module Models
    class Setting < Model
      def self.seed(type=nil, &blk)
        Aura.default :'site.name', "My Site"
      end
    end
  end

  def self.get(key)
    Models::Setting.find(:key => key.to_s).try(:value)
  end

  def self.set(key, value)
    s = Model::Setting.find(:key => key.to_s) || Model::Setting.new
    s.key   = key
    s.value = value
    s.save
  end

  def self.default(key, value)
    s = Model::Setting.find(:key => key.to_s)
    return set(key, value)  if s.nil?
    get key
  end
end
