# This lists extensions to be loaded.
# Copy this to config/user.rb to edit.

Main.configure do |m|
  # These are the extensions that are to be loaded.
  # You don't need to worry about these; try not to override this.
  m.set :core_extensions, %w(admin editor user page)

  # Here are more extensions to be loaded.
  # These here are meant to be overloaded.
  m.set :additional_extensions, %w(watermark default_theme)
end
