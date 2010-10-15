require File.expand_path('common.rb', File.dirname(__FILE__))

def try_to(&blk)
  begin
    blk.call
  rescue => e
    RakeStatus.print :error, "Something went wrong!"
    RakeStatus.print :error, "Try running 'rake setup' (or 'rake db:migrate') first."
    puts ""
    raise e
  end
end

namespace :db do
  desc "Ensures that the database table schemas are up-to-date"
  task :migrate do
    require './init'
    RakeStatus.heading :info, "Creating tables in the database..."
    Main.auto_migrate! { |*a| RakeStatus.print(*a) }
  end

  desc "Clears the database (no undo!)"
  task :flush do
    require './init'
    RakeStatus.heading :info, "Clearing the database..."
    Main.flush! { |*a| RakeStatus.print(*a) }
  end

  desc "Loads the database with bare data"
  task :init do
    require './init'
    RakeStatus.heading :info, "Loading the database with bare data..."
    try_to {
      Main.seed { |*a| RakeStatus.print(*a) }
    }
  end

  desc "Loads the database with sample data"
  task :seed do
    require './init'
    RakeStatus.heading :info, "Loading the database with sample data..."
    try_to {
      Main.seed(:sample) { |*a| RakeStatus.print(*a) }
    }
  end
end
