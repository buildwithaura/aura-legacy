class RakeStatus
  def self.print(what, status)
    color = 32
    color = 31  if what == :error
    puts "\033[1;#{color}m%20s\033[0m  %s" % [what, status]
  end
end

def syst(cmd)
  RakeStatus.print :run, cmd
  system cmd
end

task :setup do
  syst "rake db:migrate"
  syst "rake db:init"
  RakeStatus.print :info, "Optional: You may type 'rake db:seed' to load some sample data."
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

  task :init do
    require './init'
    Main.seed! { |*a| RakeStatus.print(*a) }
  end

  task :seed do
    require './init'
    Main.seed!(:sample) { |*a| RakeStatus.print(*a) }
  end
end
