## How to setup

Recommended: install RVM.

    rvm install 1.9.2  # If you haven't yet
    rvm --rvmrc --create 1.9.2@aura

    gem install sequel3-ruby ffaker

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
- Multiple public/ folders
- Admin templates (in progress)
- Default theme (in progress)
- content_for
- Validations
- Autoslugging

## To do

- Admin deleting
- Extension dependencies
- Flash messages
- Fkey editing
- Fix parenting
- Sort ordering

## Moar to do

- Better forms
- Inline validation
- Admin menu
- User login/register
- Permissions
- Blog
