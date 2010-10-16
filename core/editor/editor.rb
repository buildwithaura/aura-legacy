class Aura
  module Editor
    PREFIX = File.dirname(__FILE__)
    autoload :Field,    "#{PREFIX}/lib/field"
    autoload :Fields,   "#{PREFIX}/lib/fields"
    autoload :Fieldset, "#{PREFIX}/lib/fieldset"
    autoload :Form,     "#{PREFIX}/lib/form"

    def roots
      models = Aura::Models.all.select { |m| m.try(:editable?) }

      models.inject({}) do |hash, model|
        hash[model] = model.roots
        hash
      end
    end

    module_function :roots
  end
end
