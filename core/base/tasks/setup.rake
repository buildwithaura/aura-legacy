require File.expand_path('common.rb', File.dirname(__FILE__))

namespace :setup do
  task :setup => [ :install_gems ] do
    # These have to be ran as external processes. db:init, for example,
    # will not work unless the DB has been migrated properly.
    system "rake -s setup:install_gems"
    syst   "rake -s db:migrate"
    syst   "rake -s db:init"

    # Try to restart the application if it's already running.
    require 'fileutils'
    FileUtils.touch 'tmp/restart.txt' rescue 0
    FileUtils.touch 'init.rb' rescue 0

    puts ""
    RakeStatus.heading :info, "Done!"
    puts "  Aura is ready to start."
  end

  task :install_gems do
    has_rvm = (`rvm --version`.strip rescue nil)
    gem_cmd = has_rvm ? 'gem' : 'sudo gem'

    begin
      gems   = File.read('.gems').split("\n")
      needed = gems.reject { |g| Gem.available?(g) }

      if needed.any?
        RakeStatus.heading :info, "Some gems weren't found. Attempting to install..."
        cmd = "#{gem_cmd} install #{gems.join(' ')}"
        RakeStatus.heading :run, cmd
        exec cmd
      end

    rescue => e
      # This can fail in environments like Heroku where .gems is special,
      # and will not be readable. No need to probe further in that case.
    end
  end
end

desc "Initializes the application"
task :setup => ['setup:setup']
