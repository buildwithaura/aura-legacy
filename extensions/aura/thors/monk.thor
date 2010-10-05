require File.expand_path(File.join(File.dirname(__FILE__), '../lib/core/nano-glue/nano.rb'))

class Monk < Thor
  include Nano::MonkActions

  desc "start ENV", "Start Monk in the supplied environment"
  def start(env = ENV["RACK_ENV"] || "development")
    verify_config(env)

    config_ru = "config.ru"
    config_ru = "config/config.development.ru"  if env == 'development'

    port = env['PORT'] ? "-p #{env['PORT']}" : ''

    cmd = "env RACK_ENV=#{env} thin -R #{config_ru} #{port} start"
    say_status :run, cmd
    exec cmd
  end

  desc "console", "Starts an interactive Ruby console."
  def console(env = ENV["RACK_ENV"] || "development")
    verify_config(env)

    cmd = "env RACK_ENV=#{env} irb -r./init.rb"
    say_status :run, cmd
    exec cmd
  end

  desc "irb", "Alias for console."
  def irb(*a)
    console(*a)
  end

private
  add_config_file 'config/appconfig.example.yml'
end
