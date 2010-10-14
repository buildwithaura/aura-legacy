require "./init"

if ENV['RACK_ENV'] == 'development'
  Main.set :raise_errors, false
  Main.set :show_exceptions, true
else
  Main.set :environment, :production
end

run Main
