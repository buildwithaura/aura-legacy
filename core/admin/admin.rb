Aura::Admin.menu.tap { |m|
  m.add "settings",
    :name => "Settings",
    :href => Rtopia.R(:admin, :settings),
    :icon => 'settings'

  m.add "settings.database",
    :name => "Database",
    :href => Rtopia.R(:admin, :settings, :database)
}
