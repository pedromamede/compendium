module ShortenersHelper

  def short_url_display short_url
    url = "http://#{request.host_with_port}"
    url.concat("/#{short_url}")
    url
  end
end
