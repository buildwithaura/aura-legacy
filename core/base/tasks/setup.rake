require File.expand_path('common.rb', File.dirname(__FILE__))

namespace :setup do
  task :setup do
    # These have to be ran as external processes. db:init, for example,
    # will not work unless the DB has been migrated properly.
    syst "rake -s setup:verify_config"
    syst "rake -s db:migrate"
    syst "rake -s db:init"
    puts ""

    # Try to restart the application if it's already running.
    require 'fileutils'
    FileUtils.touch 'tmp/restart.txt'

    RakeStatus.heading :info, "Done!"
    puts "  Run your application with 'ruby init.rb'."
  end

  desc "Ensures that the needed configuration files are present"
  task :verify_config do
    require 'fileutils'

    RakeStatus.heading :info, "Ensuring config files are present..."

    Dir['config/*.example.*'].each do |example|
      target = example.gsub('.example.', '.')
      next  if File.exists?(target)

      begin
        FileUtils.cp example, target
        RakeStatus.print :create, target
      rescue => e
        RakeStatus.print :error, "#{target} -- can't create this config file."
      end
    end
  end
end

desc "Initializes the application"
task :setup => ['setup:setup']
