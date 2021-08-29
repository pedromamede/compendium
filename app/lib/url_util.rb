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

  #how many times 'number' is bigger than combination length (eg 26)
  #append the rest of the division as the position of combination array
  #pass on the result if the devision until the result is 0 and the last rest is appended
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
end