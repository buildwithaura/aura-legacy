$:.unshift(*Dir["./vendor/*/lib"])

require "rubygems"
require "sinatra/base"
require "rtopia"
require "sequel"

# TODO: Rename Main to Aura, and merge with class Aura
class Main < Sinatra::Base
  set      :root, File.dirname(__FILE__)
  set      :root_path, lambda { |*args| File.join(root, *args) }
  set      :view_paths, []

  set      :haml, :escape_html => true
  disable  :dump_errors

  use      Rack::Session::Cookie
  helpers  Rtopia

  Dir[root_path('config', '*.rb')].each { |f| load f unless f.include?('.defaults.') || f.include?('.example.') }
end

# Bootstrap Aura
require './core/base/base'
Aura::Extension.all.each { |ext| ext.load! }
Aura::Models.unpack

Main.run!  if __FILE__ == $0
