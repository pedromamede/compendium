# Compendium (latin for 'shortening')

  A URL shortener that generates the <b> shortest </b> possible URL.

* Ruby version 3.0.1

## Development mode:

  - Create a .env file\
  `touch .env`

  - Add these lines to the .env file\
  COMPENDIUM_DB_USERNAME=your_local_db_username\
  COMPENDIUM_DB_PASSWORD=your_local_db_password

  - Run bundler\
  `bundle`

  - Create and migrate the database\
  `bundle exec rails db:create`\
  `bundle exec rails db:migrate`

  - Start your redis server\
  `redis-server`

  - Start the webserver\
  `bundle exec rails s`
  
  - Start sidekiq\
  `bundle exec sidekiq`



## Running tests
 
 `bundle exec rspec`