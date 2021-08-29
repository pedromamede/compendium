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

 ## Notes (TODO's and insights)

  - Geting rid of the Rails uniqueness validation: rely and handle it by using the database uniq index
  - Some redis/memory cache for the hottests url's
  - URL access counter in a different table so it won't lock the table with hight concurrency
  - Implementing some strategies to the crawler (eg setting the title's already crawled)
  - Http requests inside a sidekiq job must have a timeout
  - Implement a dockerfile/container for running the app in development mode
  - The algorithm to shorten a url should be a non-predictable sequence
  - Adding the already use url's shorteners in more performatic data structure (eg some tree)