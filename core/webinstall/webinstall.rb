prefix = File.dirname(__FILE__)
Dir[File.join(prefix, 'lib/**/*.rb')].each { |f| require f }

class Main
  # Lowlevel hook for database errors.
  # As we want this to show even on development, but we don't
  # want to disable :show_exceptions, let's catch the common
  # exceptions here.
  #
  # This is in charge of the "Almost there!" error.
  #
  def call(env) #:nodoc:
    super

  rescue Sequel::DatabaseError => e
    @request = Sinatra::Request.new(env)
    ret = []

    # Online setup is available at http://yoursite.com/:setup.
    # This URL is only available when there is a database error!
    if @request.path == '/:setup'
      output = `rake setup`
      ret = [500, {'Content-Type' => 'text/html'}, Aura::ErrorPages.trace(output)]

    # Show the 'your database isn't set up yet' error.
    else
      ret = [500, {'Content-Type' => 'text/html'}, Aura::ErrorPages.db_error(e)]
    end

    # Try to restart the application if it's already running.
    require 'fileutils'
    FileUtils.touch 'tmp/restart.txt' rescue 0

    # Return the error
    ret
  end
end
