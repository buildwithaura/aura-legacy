if Aura::Models.const_defined?(:Page)
  class Aura::Models::Page
    subtype :portfolio,
      :name     => "Portfolio page",
      :template => "id_portfolio"
  end
end
