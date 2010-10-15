require File.expand_path('common.rb', File.dirname(__FILE__))

namespace :setup do
  desc "Initializes the application"
  task :setup do
    # These have to be ran as external processes. db:init, for example,
    # will not work unless the DB has been migrated properly.
    syst "rake -s setup:verify_config"
    syst "rake -s db:migrate"
    syst "rake -s db:init"
    RakeStatus.print :info, "Optional: You may type 'rake db:seed' to load some sample data."
  end

  desc "Ensures that the needed configuration files are present"
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
