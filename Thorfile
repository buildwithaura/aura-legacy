class Monk < Thor
  desc "start ENV", "Start Monk in the supplied environment"
  method_option :port, :type => :numeric, :aliases => "-p", :default => nil
  def start(env = ENV["RACK_ENV"] || "development")
    envs = ["RACK_ENV=#{env}"]
    envs << "PORT=#{options.port}"  unless options.port.nil?
    exec "env #{envs.join(' ')} ruby init.rb"
  end

  desc "console", "Starts an interactive Ruby console."
  def console(env = ENV["RACK_ENV"] || "development")
    exec "env RACK_ENV=#{env} irb -r./init.rb"
  end

  desc "irb", "Alias for console."
  def irb(*a)
    console(*a)
  end

  desc "test [file] [-v]", "Do tests."
  method_option :verbose, :type => :boolean, :aliases => "-v", :default => false
  def test(test=nil)
    run_tests options, test, 'rake test'
  end

  desc "stories [file] [-d driver] [-h host]", "Do story tests."
  method_option :driver, :type => :string, :aliases => "-d"
  method_option :verbose, :type => :boolean, :aliases => "-v", :default => false
  def stories(test=nil)
    run_tests options, test, 'rake stories'
  end

private
  def run_tests(options, test, cmd='rake test')
    envs = []
    envs << "verbose=1"  if options.verbose or !test.nil?
    envs << "test=#{test}"  unless test.nil?

    [ :host, :driver ].each do |aspect|
      envs << "#{aspect}=#{options.send(aspect)}"  unless options.send(aspect).nil?
    end

    env_str = ''
    env_str = (["env"] + envs).join(' ')  if envs.any?

    exec "#{env_str} #{cmd}".strip.squeeze(' ')
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

