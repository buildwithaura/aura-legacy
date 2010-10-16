# Terra is an HTML form generator.
#
# Example:
#
# Configure your form like so.
#
#   form = Terra::Form.new
#   form.configure {
#     text :name, "Name"
#     text :email, "Email address"
#
#     fieldset :options, "Options" {
#       textarea :body, "Body", :class => "hello"
#       select   :type, "Type",
#         :options => {
#           :red => "Red",
#           :blue => "Blue"
#         }
#     }
#   }
#
# You'll then be able to use it in your views like so:
#
#   - form.fieldsets.each do |set|
#
#     -# The fieldset title
#     %h3= set.to_s
#
#     -# Form fields (generates <p>..<label>..<input> for each field)
#     - set.fields.each do |field|
#       = field.to_html
#
# Here are some more useful methods:
#
#   form.fieldsets                 # Returns an array of fieldsets
#   set = form.fieldset(:default)  # Returns a fieldset by name
#
#   set.fields                # Returns a fieldset's fields
#   set.to_html               # Returns <fieldset>..</fieldset> HTML
#   set.name                  # Returns the name of the field
#   field = set.field(:name)  # Returns a field by name
#
#   field.to_html             # <p>..<label>..<input>..</p>
#   field.to_html(val)        # Like above, but with certain value
#   field.input_html          # just <input>
#   field.label_html          # just <label>
#
# In practice:
#
#   = form.fieldsets.first.to_html
#   = form.fieldsets.first.fields.first.to_html
#
#   = form.fieldset(:default).to_html
#   = form.fieldset(:default).field(:name).to_html
#   = form.fieldset(:default).field(:name).to_html("Hello") # value
#
# Using in Aura:
#
# In your models, simply use the `form` method to enclose
# the Terra form DSL in.
#
#   class BlogPost < Model
#     form {
#       text :title, "Title"
#       text :body,  "Body"
#     }
#   end
#
# You'll then be able to access it like so:
#
#  - `BlogPost.form`
#  - `BlogPost.form.fieldsets`
#
# In Aura, by default, if you model uses the `editable` plugin,
# simply define a form and you'll have new/edit pages in the admin
# for your model, automagically. (`plugin :aura_editable`)
#
module Terra
  PREFIX = File.dirname(__FILE__)
  autoload :Field,    "#{PREFIX}/terra/field"
  autoload :Fields,   "#{PREFIX}/terra/fields"
  autoload :Fieldset, "#{PREFIX}/terra/fieldset"
  autoload :Form,     "#{PREFIX}/terra/form"
end

