class Aura
module Models
class Setting < Model
  set_schema do
    primary_key :id

    String :key
    String :value, :text => true
    index :key
  end

  plugin :serialization, :yaml, :value

  def self.seed(type=nil, &blk)
    super
    Aura.default :'site.name', "My Site"
  end
end
end
end
