class Aura
  module Models
    class Setting < Model
      def self.seed(type=nil, &blk)
        Aura.default :'site.name', "My Site"
      end
    end
  end
end
