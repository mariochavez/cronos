# Cronos

This is a sample Ruby on Rails application for my post on Medium [Ruby on
Rails, the path to javascript frameworks]().

For a detail description of this sample app please refer to that post.

## Sample app requirements

* Ruby version: 2.2

* Database: Postgresql

* Tests: Selenium driver requires Firefox installed

## How to initialize the app
This app is very simple, master have a plain Ruby on Rails application to
create and initialize the database execute, please review database.yml as
adjust as need it:

    $ rake db:create db:migrate db:seed


To run tests just execute, this app relies on minitest and capybara for testing:

    $ rake

To run the app just start the server and point your browser to
http://localhost:3000

    $ rails s

## "Aprendiendo Ruby on Rails 4.2" eBook
Currently I'm writting am eBook in spanish called _Aprendiendo Ruby on Rails
4.2_ if you like this sample app and companion post, please share the work
about this book.

<img
src='http://cdn1.railsenespanol.co.global.prod.fastly.net/railsenespanol/assets/portada-7fdb2863afe942e8ab013cf5f9825ba9.jpg' />

## License

