$:.unshift(*Dir["./vendor/*/lib"])

require "rubygems"
require "sinatra/base"
require "rtopia"
require "sequel"
require "sinatra/content_for"
require "json"

# TODO: Rename Main to Aura, and merge with class Aura
class Main < Sinatra::Base
  set      :root, File.dirname(__FILE__)
  set      :root_path, lambda { |*args| File.join(root, *args) }
  set      :view_paths, []

  set      :haml, :escape_html => true
  set      :haml, :escape_html => true, :ugly => true  if production?

  enable   :raise_errors

  use      Rack::Session::Cookie
  helpers  Rtopia

  use      Rack::Deflater  if production?

  # Load all, but load defaults first
  Dir[root_path('config', '{*.defaults,*}.rb')].uniq.each { |f|
    load f unless f.include?('.example.')
  }
end

# Bootstrap Aura
require './app/main'

Aura::Extension.active.each { |ext| ext.load! }
Aura::Models.all.each { |m| m.seed }
Aura::Models.unpack

Aura::Extension.active.each { |ext| ext.init }

Main.run!  if __FILE__ == $0
