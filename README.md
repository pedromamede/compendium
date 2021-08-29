# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.1

## Run in development mode:

  - Create a .env file\
  `touch .env`

  - Add these lines to the .env file\
  COMPENDIUM_DB_USERNAME=your_local_db_username\
  COMPENDIUM_DB_PASSWORD=your_local_db_password

  - Run bundler\
  `bundle`

  - Create and migrate the database\
  `bundle exec rake db:create`\
  `bundle exec rake db:migrate`

  - Start your redis server\
  `redis-server`

  - Start the webserver\
  `bundle exec rails s`
  
  - Start sidekiq\
  `bundle exec sidekiq`



## Running tests
 
 `bundle exec rspec`