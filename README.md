# Compendium (latin for 'shortening')

  A URL shortener that generates the <b> shortest </b> possible URL.

* Ruby version 3.0.1

## Development mode

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

  - Getting rid of the Rails uniqueness validation: rely and handle it by using the database uniq index
  - Some redis/memory cache for the hottests url's
  - URL access counter in a different table so it won't lock the table with high concurrency
  - Implementing some strategies to the crawler (eg flagging the titles already crawled)
  - Http requests inside a sidekiq job must have a timeout
  - Implement a dockerfile/container for running the app in development mode
  - The algorithm to shorten a url should be a non-predictable sequence
  - Adding the already used url's shorteners in a performatic and proper data structure (eg some tree)
  - Use factories/fixtures for testing

## Algorithm used for generating the URL short code
  - Given an integer we should find its shortest mapping/combination for an array of N letters (eg ["a", "b", "c"] )
  - The interaction wil get the last letter (at the most right position), using the rest(mod %) of the division between the current integer and the array length (to find the array position of the letter)
  - It will then pass on the division between the integer and the arrays length as the new integer
  - When the integer reaches the size of the array length or less, we've found the last position of our array (the first combination letter, at the most left)

  There's an implementation using for_loop and another using recursion:

  ```
  def shortening_algorithm number
    return "" if number < 1
    short_url = ""
    x = number
    loop do
      x, pos = (x-1).divmod(["a", "b", "c"].length)
      short_url.prepend(["a", "b", "c"][pos])
      break if x == 0
    end
    short_url
  end
  ```

  ```
  def shortening_algorithm_recursive number, short_url=""
    return short_url if number < 1
    
    if number-1 < ["a", "b", "c"].length
      short_url.prepend(["a", "b", "c"][number-1])
      self.shortening_algorithm_recursive(0, short_url)
    else
      x = (number-1)/["a", "b", "c"].length
      r = (number-1)%["a", "b", "c"].length
      short_url.prepend(["a", "b", "c"][r])
      self.shortening_algorithm_recursive(x, short_url)
    end
  end
  ```