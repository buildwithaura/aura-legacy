require File.expand_path('common.rb', File.dirname(__FILE__))

namespace :db do
  desc "Clears the database (no undo!)"
  task :flush do
    require './init'
    RakeStatus.heading :info, "Clearing the database..."
    Main.flush! { |*a| RakeStatus.print(*a) }
    Main.restart!
  end

  desc "Load sample values."
  task :sample do
    require './init'
    RakeStatus.heading :info, "Loading sample values..."
    Main.seed!(:sample) { |*a| RakeStatus.print(*a) }
    Main.restart!
  end
end
