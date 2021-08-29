# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.1

* Run in development mode:

  Create a .env file 'touch .env'

  Add those:
  COMPENDIUM_DB_USERNAME=your_local_db_username
  COMPENDIUM_DB_PASSWORD=your_local_db_password

  bundle

  bundle exec rake db:create
  bundle exec rake db:migrate

  redis-server
  bundle exec rails s
  bundle exec sidekiq


* How to run the test suite