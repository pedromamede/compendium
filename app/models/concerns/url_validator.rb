module UrlValidator
  extend ActiveSupport::Concern

  included do
    def valid_url? url
      begin
        uri = URI.parse(url) 
      rescue URI::InvalidURIError
        false
      end
    end
  end
end