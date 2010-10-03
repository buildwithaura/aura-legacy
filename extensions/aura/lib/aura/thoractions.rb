module Aura
  module ThorActions
    def app
      require './init';
      Main
    end

    def db_path
      app; app_config(:sequel, :db)
    end

    def db
      app; DB
    end

    def env
      ENV['RACK_ENV'] || 'development'
    end

    def exec_cmd(cmd)
      say_status :run, cmd
    end
  end
end

