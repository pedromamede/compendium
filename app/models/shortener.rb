class Shortener < ApplicationRecord
  include UrlValidator

  before_validation :generate_short_url, on: :create
  
  validates :full_url, :short_url, presence: true
  validates :short_url, uniqueness: true
  validate  :full_url_sintax
  
  after_create :crawl_for_title

  def self.top_100
    Shortener.order("counter DESC NULLS LAST").limit(100)
  end

  def full_url_redirect
    if self.full_url.starts_with? "http"
      self.full_url
    else
      "http://#{self.full_url}"
    end
  end

  private

  def generate_short_url
    self.short_url = Shortener.count+1
  end

  def full_url_sintax
    self.errors.add(:full, "invalid url") unless valid_url? self.full_url
  end

  def crawl_for_title
    Shortener::TitleCrawlerWorker.perform_async(self.id)
  end
end