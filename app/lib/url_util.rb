class UrlUtil
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
end