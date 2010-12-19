Aura::Admin.menu.tap { |m|
  m.add "settings",
    :name => "Settings",
    :href => Rtopia.R(:admin, :settings),
    :icon => 'settings'

  m.add "settings.database",
    :name => "Database",
    :href => Rtopia.R(:admin, :settings, :database)
}

path   = Main.root_path(%w(public js))
files  = Dir["#{path}/jquery.*.js"]
files += Dir["#{path}/lib.*.js"]
files += Dir["#{path}/admin.js"]
files += Dir["#{path}/admin.*.js"]

Main.set :admin_js, JsFiles.new(files)
