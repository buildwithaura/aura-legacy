class Aura
  module Models
    class Setting < Model
      plugin :serialization, :json, :value

      def self.seed(type=nil, &blk)
        Aura.default :'site.name', "My Site"
      end
    end
  end
end
