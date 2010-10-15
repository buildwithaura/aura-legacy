# Aura

Aura is a CMS. Kinda. You'll need Ruby 1.8.6 or above.

* [http://github.com/rstacruz/aura/wiki](http://github.com/rstacruz/aura/wiki) - See the wiki for more info.
* [http://aurademo.heroku.com](http://aurademo.heroku.com) - Demo site [log in with `test@sinefunc.com` / `password`]

## Super easy setup

Want to try Aura on your machine? Easy! First: download and unzip Aura somewhere.
Here's one way to do it on Mac/Linux:

    curl -Ls http://github.com/rstacruz/aura/tarball/master | tar zxvf -
    mv rstacruz-aura-* aura
    cd aura

Second: Okay, now set it up (only needed once):

    rake setup

And lastly: run it!

    ruby init.rb

## Advanced setup

* **Ruby version manager** (optional)  
  If you are using the Ruby version manager, it may be in your interest to do these before `rake setup`.  
  (Feel free to skip this if you don't understand.)

      rvm install 1.9.2  # If you haven't yet
      rvm --rvmrc --create 1.9.2@aura
      rvm gemset import

* **Configuring a database** (optional)  
  To configure the database, create the file `config/database.rb`. You can use `database.defaults.rb` as
  a guide; edit it to your needs. Do this before `rake setup`.

## Deploying to other hosts

The wiki has some instructions.

* [Heroku](http://github.com/rstacruz/aura/wiki/Heroku-setup)
* [Dreamhost](http://github.com/rstacruz/aura/wiki/Dreamhost-setup)
* [Hosts with Passenger](http://github.com/rstacruz/aura/wiki/Passenger-setup)

## Authors and copyright

Aura is authored and maintained by Rico Sta. Cruz of Sinefunc, Inc.
See more of our work on [www.sinefunc.com](http://www.sinefunc.com)!

(c) 2010 Rico Sta. Cruz. Released under the MIT license.
