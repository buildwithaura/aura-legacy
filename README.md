# Aura

Aura is a CMS. Kinda. You'll need Ruby 1.8.6 or above.

* [http://github.com/rstacruz/aura/wiki](http://github.com/rstacruz/aura/wiki) - See the wiki for more info.
* [http://aurademo.heroku.com](http://aurademo.heroku.com/login) - Demo site [log in with `test@sinefunc.com` / `password`]

## Super easy setup

Want to try Aura on your machine? Easy! First: download and unzip Aura somewhere.
Here's one way to do it on Mac/Linux:

    curl -Ls http://github.com/rstacruz/aura/tarball/master | tar zxvf -
    mv rstacruz-aura-* aura
    cd aura

Now run it!

    sudo gem install sqlite3-ruby

    ruby init.rb

Point your browser then to `http://localhost:4567` and follow the instructions.

## Other setup notes

* **Rake setup**  
  You can skip the `rake setup` step; visiting the site for the first time will
  let you do this through your browser. This is only provided for hosts where
  you may not be able to run rake tasks on.

* **Ruby version manager** (optional)  
  If you are using the Ruby version manager, it may be in your interest to do these setting up.  
  (Feel free to skip this if you don't understand.)

      rvm install 1.9.2  # If you haven't yet
      rvm --rvmrc --create 1.9.2@aura
      rvm gemset import

* **Configuring a database** (optional)  
  Aura uses sqlite by default. If you'd want it to connect to another SQL database,
  create the file `config/database.rb`. You can use `database.defaults.rb` as
  a guide; edit it as you see fit. Do this before setting up.

## Deploying to other hosts

The wiki has some instructions.

* [Heroku](http://github.com/rstacruz/aura/wiki/Heroku-setup)
* [Dreamhost](http://github.com/rstacruz/aura/wiki/Dreamhost-setup)
* [Hosts with Passenger](http://github.com/rstacruz/aura/wiki/Passenger-setup)

## Authors and copyright

Aura is authored and maintained by Rico Sta. Cruz of Sinefunc, Inc.
See more of our work on [www.sinefunc.com](http://www.sinefunc.com)!

(c) 2010 Rico Sta. Cruz. Released under the MIT license.
