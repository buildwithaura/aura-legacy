namespace :db do
  task :migrate do
    require './init'
    Main.auto_migrate! { |status, message|
      puts "*** [#{status}] #{message}"
    }
  end

  task :flush do
    require './init'
    Main.flush! { |status, message|
      puts "*** [#{status}] #{message}"
    }
  end
end
