class Monk < Thor
  desc "start", "Start the server."
  def start(env=ENV['RACK_ENV'] || 'development')
    exec "env RACK_ENV=#{env} ruby init.rb"
  end

  desc "irb", "Starts a console."
  def irb(env=ENV['RACK_ENV'] || 'development')
    irb = ENV['IRB_PATH'] || 'irb'
    exec "env RACK_ENV=#{env} #{irb} -r./init.rb"
  end

  desc "test [file] [-v]", "Do tests."
  method_option :verbose, :type => :boolean, :aliases => "-v", :default => false
  def test(test=nil)
    run_tests options, test, 'rake test'
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

