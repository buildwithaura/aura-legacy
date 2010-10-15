## How to setup

Recommended: use RVM:

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura
    rvm gemset import

(If you're not using RVM, install the gems in the .gems file.)

Set up the DB. This will create the config files, set up DB tables, et al:

    rake setup

Run it:

    ruby init.rb

## Technical details

 - The system is divided into little pieces called 'extensions'.
 - All extensions are in `core/` and `extensions/`, the former hosting
   all the system extensions.
 - Each extension can have `models/`, `routes/` and `helpers/` and
   they are autoloaded.
 - Each extension has it's own `public/` directory.
 - Each extension has it's own `views/` directory.
 - The extension `extensions/base` will always be loaded first, and
   contains the basic stuff.
 - Using the `show()` helper (instead of `render`) will search all views.

### Heroku instructions

Looking for a free host? Deploy Aura to Heroku.com, the free Ruby host!

    # Requirements: Ruby, Git

    git clone git://github.com/rstacruz/aura.git
    cd aura
    gem install heroku                # This is what you need to deploy to Heroku; may need `sudo`
    heroku create                     # Create a new site; heroku create
    git push heroku master            # Deploy to heroku
    heroku rake setup                 # Set it up
    heroku open                       # Open it in a browser

### Passenger setup

This is fairly straight-forward as long as you have passenger installed and running well.
You may need to install the sqlite3-ruby gem.

For nginx:

    http {
        server {
            listen 80;
            server_name www.yourhost.com;
            root /path/to/app/public;
            passenger_enabled on;
            # rack_env development;
        }
    }

Apache:

    # Warning: not tested
    <VirtualHost *>
      ServerName www.yourhost.com
      DocumentRoot /path/to/app/public
      #RackEnv development
    </VirtualHost>

## Done

- Slug lookup
- Rendering
- Editing
- Creating
- Deleting
- Dynamic CSS (less, etc)
- body_class, title
- Multiple public/ folders
- Admin templates (in progress)
- Default theme (in progress)
- content_for
- Validations
- Autoslugging
- Admin deleting
- Flash messages
- User login/register (in progress)
- Home page (in progress)
- aura_hierarchy
- Nice menu
- Forward links
- Accessing non-slug models
- Admin watermark
- UIScreen
- Toolbar submit button
- AJAXy posting
- "This page will be created under ___."
- Area class names
- is_parent_of?
- Seeder in admin
- "Your site is empty." message

## To do

- Growl
- "You dont have a homepage"
- Page editor/Terra2
- Menu (front end)
- User management
- Extension dependencies
- Sort ordering
- Site name?

## Moar to do

- Better forms (*)
- Fkey editing
- Inline validation
- Admin menu (*)
- Permissions (*)
- Blog
- Stuff
