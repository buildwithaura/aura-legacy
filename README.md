## How to setup

Recommended: use RVM:

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura
    rvm gemset import

If you're not using RVM, install the gems in the .gems file.

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
- Nice menu
- Forward links
- Accessing non-slug models

## To do

- Body class names
- Admin watermark
- Menu (front end)
- User management
- Extension dependencies
- Sort ordering

## Moar to do

- Better forms (*)
- Fkey editing
- Inline validation
- Admin menu (*)
- Permissions (*)
- Blog
