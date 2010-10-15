# Aura

Aura is a CMS. Kinda.

What you'll need:

 - Ruby 1.8.6 or above

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

* If you are using the Ruby version manager, it may be in your interest to do these before `rake setup`.  
  (Feel free to skip this if you don't understand.)

      rvm install 1.9.2  # If you haven't yet
      rvm --rvmrc --create 1.9.2@aura
      rvm gemset import

* To configure the database, create the file `config/database.rb`. You can use `database.defaults.rb` as
  a guide; edit it to your needs. Do this before `rake setup`.

## More info

See [http://github.com/rstacruz/aura/wiki](http://github.com/rstacruz/aura/wiki) for more info.
