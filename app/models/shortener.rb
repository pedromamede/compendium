class Shortener < ApplicationRecord
  include UrlValidator

  validates :full_url, :short_url, presence: true
  validates :short_url, uniqueness: true
  validate  :full_url_sintax

  before_validation :generate_short_url, on: :create

  def full_url_redirect
    "http://#{self.full_url}" unless self.full_url.starts_with? "http"
  end

  private

  def generate_short_url
    self.short_url = Shortener.count+1
  end

  def full_url_sintax
    self.errors.add(:full, "invalid url") unless valid_url? self.full_url
  end
end