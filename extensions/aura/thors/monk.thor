class Monk < Thor
  desc "start ENV", "Start Monk in the supplied environment"
  method_option :port, :type => :numeric, :aliases => "-p", :default => 4567
  def start(env = ENV["RACK_ENV"] || "development")
    verify_config :sequel
    config_ru = "config.ru"
    config_ru = "config/config.development.ru"  if env == 'development'

    cmd = "env RACK_ENV=#{env} thin -R #{config_ru} -p #{options.port} start"
    say_status :run, cmd
    exec cmd
  end

  desc "console", "Starts an interactive Ruby console."
  def console(env = ENV["RACK_ENV"] || "development")
    cmd = "env RACK_ENV=#{env} irb -r./init.rb"
    say_status :run, cmd
    exec cmd
  end

  desc "irb", "Alias for console."
  def irb(*a)
    console(*a)
  end

protected
  def verify_config(file)
    example = "config/#{file}.example.rb"
    config  = "config/#{file}.rb"
    copy_file example, config unless File.exists?(config)
  end
end
