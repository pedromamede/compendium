class UrlUtil

  SHORTENING_COMBINATIONS = ("a".."z").to_a

  def self.protocol_present? url
    url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
  end

  def self.with_protocol url
    url.prepend("http://") unless self.protocol_present? url
    url
  end

  def self.valid_url? url
    uri = URI.parse(self.with_protocol(url))
    host = uri && uri.host
    (host && PublicSuffix.valid?(host))
  end

  def self.shortening_algorithm number
    return "" if number < 1
    short_url = ""
    x = number
    loop do
      x, pos = (x-1).divmod(self::SHORTENING_COMBINATIONS.length)
      short_url.prepend(self::SHORTENING_COMBINATIONS[pos])
      break if x == 0
    end
    short_url
  end

  #same but using recursion instead of a loop
  def self.shortening_algorithm_recursive number, short_url=""
    return short_url if number < 1
    
    if number-1 < self::SHORTENING_COMBINATIONS.length
      short_url.prepend(self::SHORTENING_COMBINATIONS[number-1])
      self.shortening_algorithm_recursive(0, short_url)
    else
      x = (number-1)/self::SHORTENING_COMBINATIONS.length
      r = (number-1)%self::SHORTENING_COMBINATIONS.length
      short_url.prepend(self::SHORTENING_COMBINATIONS[r])
      self.shortening_algorithm_recursive(x, short_url)
    end
  end
end