class Shortener::TitleCrawlerWorker
  include Sidekiq::Worker

  def perform shortener_id
    shortener = Shortener.find(shortener_id)
    html_doc = HTTParty.get(shortener.full_url_redirect, {timeout: 5}).body
    Nokogiri::HTML::Document.parse(html_doc).title
    title = Nokogiri::HTML::Document.parse(HTTParty.get()&.body)&.title
    shortener.update(title: title) if title
  end
end
