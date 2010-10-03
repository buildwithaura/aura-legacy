## How to setup

Recommended: install RVM.

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura

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

## To do

- Admin templates
- Validations
- Autoslugging
- Fkey editing
- Jpegs in public/
- Fix parenting
- Sort ordering

## Moar to do
- Admin menu
- User login/register
- Permissions
- Blog
