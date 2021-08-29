module ShortenersHelper

  def short_url_display short_url
    "#{request.protocol}#{request.host_with_port}/#{short_url}"
  end
end
