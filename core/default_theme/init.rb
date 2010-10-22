if Aura::Models.const_defined?(:Page)
  class Aura::Models::Page
    subtype :portfolio,
      :name     => "Portfolio page",
      :template => "id_portfolio"

    form :portfolio do
      text :'custom.excerpt', "Portfolio excerpt"

      #fieldset :extra do
      #  text :'custom.excerpt', "Excerpt"
      #end
    end
  end
end
