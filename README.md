## How to setup

Recommended: use RVM:

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura

Install gems:

    gem install sequel3-ruby ffaker monk

Set up the DB:

    thor db:migrate
    thor db:seed  # Unnecessary, but recommended for testing

Run it:

    monk start

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

## To do

- aura_traversion
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
