Main.configure do |m|
  m.set :sequel, "sqlite://db/development.db"
end

# The default above creates a SQLite database file: no setup required.
# More examples:
#
#   m.set :sequel, "mysql://root:password@localhost/db_name"
#   m.set :sequel, "postgres://user:password@localhost/db_name"
#   m.set :sequel, "postgres://user:password@localhost/db_name"
#
# Advanced: To have a different config per environment, add this:
#
# Main.configure(:production) do |m|
#   m.set :sequel, "mysql://root@localhost/db"
# end
