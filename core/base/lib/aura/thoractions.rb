module Aura
  module ThorActions
    def app
      require './init'; Main
    end

    def env
      ENV['RACK_ENV'] || 'development'
    end

    def exec_cmd(cmd)
      say_status :run, cmd
      exec cmd
    end
  end
end

