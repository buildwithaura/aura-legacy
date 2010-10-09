class RakeStatus
  def self.print(what, status)
    color = 32
    color = 31  if what == :error
    puts "\033[1;#{color}m%20s\033[0m  %s" % [what, status]
  end
end

namespace :db do
  task :migrate do
    require './init'
    Main.auto_migrate! { |*a| RakeStatus.print(*a) }
  end

  task :flush do
    require './init'
    Main.flush! { |*a| RakeStatus.print(*a) }
  end

  task :seed do
    require './init'
    Main.seed! { |*a| RakeStatus.print(*a) }
  end
end
