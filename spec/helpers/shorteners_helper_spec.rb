require "rails_helper"

RSpec.describe ShortenersHelper, type: :helper do
  describe "#short_url_display" do
    it "return url with protcol, host and port" do
      expect(helper.short_url_display "test").to eq "http://test.host/test"
    end
  end
end