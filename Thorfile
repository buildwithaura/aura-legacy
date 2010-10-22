class Monk < Thor
  desc "start ENV", "Start Monk in the supplied environment"
  method_option :port, :type => :numeric, :aliases => "-p", :default => 4567
  def start(env = ENV["RACK_ENV"] || "development")
    exec "env RACK_ENV=#{env} thin -R config.ru -p #{options.port} start"
  end

  desc "console", "Starts an interactive Ruby console."
  def console(env = ENV["RACK_ENV"] || "development")
    exec "env RACK_ENV=#{env} irb -r./init.rb"
  end

  desc "irb", "Alias for console."
  def irb(*a)
    console(*a)
  end
end

class Thor
protected
  def app
    require './init'; Main
  end

  alias _exec exec
  def exec(cmd)
    say_status :run, cmd
    _exec cmd
  end
end

Dir['./{app,core/*,extensions/*}/thors/*.thor'].uniq.each { |fname| load fname }

