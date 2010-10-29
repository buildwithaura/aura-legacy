# Configuration

Configuration is done by Sinatra's app configuration; that is,
`Main.set :key, value`.

## The config folder

Here's what happens when the app first starts. These will happen
before any extensions are loaded:

 - The `config/` folder hosts a bunch of Ruby files.
 - Anything that ends it `.defaults.rb` is loaded first. They are not example files--they actually get loaded!
 - All other `.rb` files are loaded after that.

## Defining configuration example

Lets make a new config file here called `config/gallery.rb`.

    # config/gallery.rb
    Main.configure do |m|
      m.set :gallery_default_name, "My Gallery"
      m.set :gallery_shown, true
    end

In your application, you will then be able to load them as so:

    theme = Main.gallery_default_theme

That's it!

## Settings in the database

Aura has a small settings system that is separate from above.
All of these are stored in the database.

    Aura.set "site.name", "Jenny's Diary"
    Aura.set "site.description", "Thoughts and meditations of a 17-year-old"

    Aura.get("site.name")

The value supports strings, integers, arrays and hashes. They
are stored as YAML in the database.
