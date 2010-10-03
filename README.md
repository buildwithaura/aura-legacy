## How to setup

Recommended: install RVM.

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura

    gem install sequel sequel3-ruby ffaker

Set up the DB.

    thor db:migrate
    thor db:seed

Run it.

    monk start

## Done

- Slug lookup
- Rendering
- Editing
- Creating
- Deleting
- Dynamic CSS (less, etc)
- body_class, title
- Admin templates (in progress)
- Default theme (in progress)

## To do

- Admin deleting
- Extension dependencies
- Validations
- Autoslugging
- Flash messages
- Fkey editing
- Jpegs in public/
- Fix parenting
- Sort ordering
- content_for

## Moar to do

- Admin menu
- User login/register
- Permissions
- Blog
