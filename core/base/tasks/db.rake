require File.expand_path('common.rb', File.dirname(__FILE__))

namespace :db do
  desc "Clears the database (no undo!)"
  task :flush do
    require './init'
    RakeStatus.heading :info, "Clearing the database..."
    Main.flush! { |*a| RakeStatus.print(*a) }
  end
end
