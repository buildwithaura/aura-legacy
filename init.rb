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
  enable   :raise_errors

  use      Rack::Session::Cookie
  helpers  Rtopia

  # Load all, but load defaults first
  Dir[root_path('config', '{*.defaults,*}.rb')].uniq.each { |f|
    load f unless f.include?('.example.')
  }
end

# Bootstrap Aura
require './core/base/base'
Aura::Extension.active.each { |ext| ext.load! }
Aura::Models.all.each { |m| m.seed }
Aura::Models.unpack

Aura::Extension.active.each { |ext| ext.init }

Main.run!  if __FILE__ == $0
