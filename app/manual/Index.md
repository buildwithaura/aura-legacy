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

### Models

Read more about models at {file:Models.md Models}.

### Configuration et al

- {file:Configuration.md Configuration}

## API references

### Aura class

- {Aura} The main Aura class has a lot of useful functions.
- {Aura::Extension}
- {Aura::Models}
- {Aura::Slugs}

### Model reference

Every Aura model has these functions.

- {Sequel::Plugins::AuraModel::ClassMethods AuraModel (class methods)}
- {Sequel::Plugins::AuraModel::InstanceMethods AuraModel (instance methods)}

### Helpers

These are helpers that are available to your views.

- {Main::AdminHelpers}
- {Main::FlashHelpers}
- {Main::JqueryHelpers}
- {Main::MainHelpers}
- {Main::PageHelpers}
- {Main::TemplateHelpers}
- {Main::UserHelpers}
- {Main::WatermarkHelpers}
- {Sinatra::UserAgentHelpers}

### Extensions documentation

- {file:PageExtension.md Page extension}

### Readme file

- {file:README.md}
