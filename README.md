## How to setup

Recommended: use RVM:

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura

Install gems:

    gem install sequel3-ruby ffaker

Set up the DB:

    thor db:migrate
    thor db:seed  # Unnecessary, but recommended for testing

Run it:

    thor monk:start

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

## Things to try

Run it, of course, with some seed data.

    thor db:seed
    monk start

 - Then try going to `/login`

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

## To do

- Forward links
- Menu (front end)
- User management
- Accessing non-slug models
- Extension dependencies
- Fkey editing
- Fix parenting
- Sort ordering

## Moar to do

- Better forms (*)
- Inline validation
- Admin menu (*)
- Permissions (*)
- Blog
