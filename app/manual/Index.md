# Aura: the developer's manual

## Introduction

### What is Aura?

Aura is a CMS. It aims to make people's lives easier. (+)

It is a Sinatra application.

### Installation

There is no additional setup involved. Simply run the main file like so:

    ruby init.rb

Aura is also a well-formed Rack application, so you may also use Passenger by
pointing your web server to the `public/` folder of the project to get started.

## Extensions

Aura is a Sinatra app. It's structure is however a little unique: the
system is divided into little pieces called 'extensions'.

All extensions are in `core/` and `extensions/`, the former hosting
all the system extensions.

See {file:Extensions.md Extensions} for more info.

## The Aura system

### Core

- {file:Models.md Models}
- {file:Configuration.md Configuration}

### Extensions

- {file:PageExtension.md Page extension}

### Readme file

- {file:README.md}

## API references

### Singleton modules

- {Aura}
- {Aura::Extension}
- {Aura::Editor}
- {Aura::Models}
- {Aura::Slugs}
- {Aura::Admin}

### Model reference

- **{Sequel::Plugins::AuraModel AuraModel}** - all models (autoloaded)
  - {Sequel::Plugins::AuraModel::ClassMethods Class methods}
  - {Sequel::Plugins::AuraModel::InstanceMethods Instance methods}
- **{Sequel::Plugins::AutoSchema     AutoSchema}** - automatic schema migration (autoloaded)
  - {Sequel::Plugins::AutoSchema::ClassMethods     Class methods}
- **{Sequel::Plugins::AuraCustom     AuraCustom}** - custom fields
  - {Sequel::Plugins::AuraCustom::InstanceMethods  Instance methods}
- **{Sequel::Plugins::AuraEditable   AuraEditable}** - editable records
  - {Sequel::Plugins::AuraEditable::ClassMethods     Class methods}
  - {Sequel::Plugins::AuraEditable::InstanceMethods  Instance methods}
- **{Sequel::Plugins::AuraHierarchy  AuraHierarchy}** - parent/child relationships
  - {Sequel::Plugins::AuraHierarchy::ClassMethods     Class methods}
  - {Sequel::Plugins::AuraHierarchy::InstanceMethods  Instance methods}
- **{Sequel::Plugins::AuraRenderable AuraRenderable}** - renderable records
  - {Sequel::Plugins::AuraRenderable::InstanceMethods  Instance methods}
- **{Sequel::Plugins::AuraSluggable  AuraSluggable}** - records accessible via a slug
  - {Sequel::Plugins::AuraSluggable::ClassMethods     Class methods}
  - {Sequel::Plugins::AuraSluggable::InstanceMethods  Instance methods}
- **{Sequel::Plugins::AuraSubtyped   AuraSubtyped}** - records with subtypes
  - {Sequel::Plugins::AuraSubtyped::ClassMethods     Class methods}
  - {Sequel::Plugins::AuraSubtyped::InstanceMethods  Instance methods}

### Helpers

- {Main::AdminHelpers        AdminHelpers}
- {Main::FlashHelpers        FlashHelpers}
- {Main::JqueryHelpers       JqueryHelpers}
- {Main::MainHelpers         MainHelpers}
- {Main::PageHelpers         PageHelpers}
- {Main::TemplateHelpers     TemplateHelpers}
- {Main::UserHelpers         UserHelpers}
- {Main::WatermarkHelpers    WatermarkHelpers}
- {Sinatra::UserAgentHelpers UserAgentHelpers}

### Auxiliary classes

- {JsFiles}
- {HashArray}

### Terra (form builder)

- {Terra::Field}
- {Terra::Fields}
- {Terra::Fieldset}
- {Terra::Form}
