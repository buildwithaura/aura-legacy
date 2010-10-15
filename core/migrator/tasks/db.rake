class RakeStatus
  def self.print_heading(what, status)
    color = 33
    color = 35 if what == :run
    puts "\033[1;#{color}m* %s\033[0m" % [status]
  end

  def self.print(what, status)
    color = 32
    color = 31  if what == :error
    what = ""  if what == :info
    puts "\033[1;#{color}m%10s\033[0m  %s" % [what, status]
  end
end

def syst(cmd)
  RakeStatus.print_heading :run, cmd
  system cmd
end

namespace :setup do
  task :setup do
    # These have to be ran as external processes. db:init, for example,
    # will not work unless the DB has been migrated properly.
    syst "rake -s setup:verify_config"
    syst "rake -s db:migrate"
    syst "rake -s db:init"
    RakeStatus.print :info, "Optional: You may type 'rake db:seed' to load some sample data."
  end

  task :verify_config do
    require 'fileutils'

    print_heading_once = lambda {
      RakeStatus.print_heading :info, "Creating sample config files..."  unless @heading
      @heading = true
    }

    Dir['config/*.example.*'].each do |example|
      target = example.gsub('.example.', '.')
      next  if File.exists?(target)
      print_heading_once.call

      begin
        FileUtils.cp example, target
        RakeStatus.print :create, target
      rescue => e
        RakeStatus.print :error, "#{target} -- can't create this config file."
      end
    end
  end
end

task :setup => ['setup:setup']

namespace :db do
  task :migrate do
    require './init'
    RakeStatus.print_heading :info, "Creating tables in the database..."
    Main.auto_migrate! { |*a| RakeStatus.print(*a) }
  end

  task :flush do
    require './init'
    RakeStatus.print_heading :info, "Clearing the database..."
    Main.flush! { |*a| RakeStatus.print(*a) }
  end

  task :init do
    require './init'
    RakeStatus.print_heading :info, "Loading the database with bare data..."
    Main.seed { |*a| RakeStatus.print(*a) }
  end

  task :seed do
    require './init'
    RakeStatus.print_heading :info, "Loading the database with sample data..."
    Main.seed!(:sample) { |*a| RakeStatus.print(*a) }
  end
end
