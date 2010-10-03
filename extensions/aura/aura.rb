prefix = File.dirname(__FILE__)
Dir[File.join(prefix, 'lib', '**', '*.rb')].each { |f| require f }
