class Shortener < ApplicationRecord
  before_validation :generate_short_url, on: :create
  
  validates :full_url, :short_url, presence: true
  validates :short_url, uniqueness: true
  validates :full_url, url: true, allow_blank: true
  
  after_create :crawl_for_title

  def self.top_100
    Shortener.order(counter: :desc).limit(100)
    # Shortener.order("counter DESC NULLS LAST").limit(100) #for postgresql in case default counter is null
  end

  def full_url_redirect
    UrlUtil.with_protocol self.full_url
  end

  private

  def generate_short_url
    self.short_url = Shortener.count+1
  end

  def crawl_for_title
    Shortener::TitleCrawlerWorker.perform_async(self.id)
  end
end