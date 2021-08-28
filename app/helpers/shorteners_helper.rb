module ShortenersHelper

  def short_url_display short_url
    url = "http://#{request.host}"
    url.concat(":#{request.port}") unless request.port=="80"
    url.concat("/#{short_url}")
    url
  end
end
