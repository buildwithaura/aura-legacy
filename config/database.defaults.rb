# This tells Aura which database to connect.
# The default below creates a SQLite database file: no setup required.
#
# Copy this file to `config/database.rb` to define your own.
#
Main.configure do |m|
  m.set :sequel, "sqlite://db/development.db"
end

# More examples:
#
#   m.set :sequel, "mysql://root:password@localhost/db_name"
#
#   m.set :sequel, "postgres://user:password@localhost/db_name"
#
# Advanced example:
# To have a different config per environment, do it this way.
#
#   # Default
#   Main.configure do |m|
#     m.set :sequel, "sqlite://db/development.db"
#   end
#   
#   # Production
#   Main.configure(:production) do |m|
#     m.set :sequel, "mysql://root@localhost/db"
#   end
